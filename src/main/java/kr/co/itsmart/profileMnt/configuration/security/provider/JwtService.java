package kr.co.itsmart.profileMnt.configuration.security.provider;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class JwtService {
    @Value("${spring.security.jwt.secret-key}")
    private String secretKey;
    @Value("${spring.security.jwt.expiration}")
    private long jwtExpiration; // 1 day
    @Value("${spring.security.jwt.refresh-token.expiration}")
    private long refreshExpiration; // 7 day

    private final Logger log = LoggerFactory.getLogger(this.getClass());

    /**
     * token 생성
     *
     * @param userDetails
     * @param expiration
     */
    public String generateToken(UserDetails userDetails, long expiration) {
        Map<String, Object> extraClaims = new HashMap<>();
        extraClaims.put("roles", extractRoles(userDetails));

        return buildToken(extraClaims, userDetails, expiration);
    }

    /**
     * access token 생성
     *
     * @param userDetails
     */
    public String generateAccessToken(UserDetails userDetails) {
        return generateToken(userDetails, jwtExpiration);
    }

    /**
     * refresh token 생성
     *
     * @param userDetails
     */
    public String generateRefreshToken(UserDetails userDetails) {
        return generateToken(userDetails, refreshExpiration);
    }

    /**
     * JWT token 생성
     *
     * @param extraClaims
     * @param userDetails
     * @param expiration
     * @return token
     */
    private String buildToken(Map<String, Object> extraClaims, UserDetails userDetails, long expiration) {
        return Jwts.builder()
                .setClaims(extraClaims)
                .setSubject(userDetails.getUsername())
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + expiration))
                .signWith(getSignInKey(), SignatureAlgorithm.HS256).compact();
    }

    /**
     * token 검증
     *
     * @param token
     * @param userDetails
     */
    public boolean isTokenValid(String token, UserDetails userDetails) {
        log.info("[isTokenValid]");
        final String username = extractUsername(token);
        return (username.equals(userDetails.getUsername())) && !isTokenExpired(token);
    }

    /**
     * token username 조회
     *
     * @param token
     */
    public String extractUsername(String token) {
        return extractClaim(token, Claims::getSubject);
    }

    /**
     * token payload 조회
     *
     * @param token
     * @param claimResolver
     */
    public <T> T extractClaim(String token, Function<Claims, T> claimResolver) {
        final Claims claims = extractAllClaims(token);
        return claimResolver.apply(claims);
    }

    /**
     * token parsing
     *
     * @param token
     */
    private Claims extractAllClaims(String token) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(getSignInKey())
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        } catch (ExpiredJwtException e){
            log.warn("[extractAllClaims] token expired.");
            return e.getClaims();
        }
    }

    /**
     * token 유효성 여부 조회
     *
     * */
    private boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }

    /**
     * token 유효기간 조회
     *
     * @param token
     * */
    private Date extractExpiration(String token) {
        return extractClaim(token, Claims::getExpiration);
    }

    /**
     * secretKey 조회
     *
     * */
    private Key getSignInKey() {
        byte[] keyByte = Decoders.BASE64.decode(secretKey);
        return Keys.hmacShaKeyFor(keyByte);
    }

    /**
     * token userRole 조회
     *
     * @param userDetails
     * */
    private List<String> extractRoles(UserDetails userDetails){
        return userDetails.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toList());
    }
}
