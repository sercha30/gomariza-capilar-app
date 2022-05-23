package com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.service;

import com.chamorrogarciasergio.pdam.gomarizacapilarapp.general.BaseService;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.media.ImageScaler;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.storage.s3.FileService;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.dto.CreateUsuarioDto;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.model.UserRole;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.model.Usuario;
import com.chamorrogarciasergio.pdam.gomarizacapilarapp.usuario.repos.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@Service("userDetailsService")
@RequiredArgsConstructor
public class UsuarioService extends BaseService<Usuario, UUID, UsuarioRepository> implements UserDetailsService {

    private final PasswordEncoder passwordEncoder;
    private final FileService fileService;
    private final ImageScaler imageScaler;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        return this.repositorio.findFirstByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException(email + " no encontrado."));
    }

    public Usuario saveCliente(CreateUsuarioDto nuevoUsuario, MultipartFile foto) throws Exception {
        if(nuevoUsuario.getPassword().contentEquals(nuevoUsuario.getPassword2())) {
            String uri;
            try {
                MultipartFile thumbnail = imageScaler.resizeAvatarImage(foto);
                uri = fileService.save(thumbnail);
            } catch (Exception ex) {
                throw new Exception("Error al subir la imagen de perfil");
            }

            Usuario usuario = Usuario.builder()
                    .password(passwordEncoder.encode(nuevoUsuario.getPassword()))
                    .apellidos(nuevoUsuario.getApellidos())
                    .foto(uri)
                    .email(nuevoUsuario.getEmail())
                    .nombre(nuevoUsuario.getNombre())
                    .rol(UserRole.CLIENTE)
                    .build();
            return save(usuario);
        } else {
            return null;
        }
    }

    public Usuario saveEmpleado(CreateUsuarioDto nuevoUsuario, MultipartFile foto) throws Exception {
        if(nuevoUsuario.getPassword().contentEquals(nuevoUsuario.getPassword2())) {
            String uri;
            try {
                MultipartFile thumbnail = imageScaler.resizeAvatarImage(foto);
                uri = fileService.save(thumbnail);
            } catch (Exception ex) {
                throw new Exception("Error al subir la imagen de perfil");
            }

            Usuario usuario = Usuario.builder()
                    .password(passwordEncoder.encode(nuevoUsuario.getPassword()))
                    .apellidos(nuevoUsuario.getApellidos())
                    .foto(uri)
                    .email(nuevoUsuario.getEmail())
                    .nombre(nuevoUsuario.getNombre())
                    .rol(UserRole.EMPLEADO)
                    .build();
            return save(usuario);
        } else {
            return null;
        }
    }

    public Usuario saveAdmin(CreateUsuarioDto nuevoUsuario, MultipartFile foto) throws Exception {
        if(nuevoUsuario.getPassword().contentEquals(nuevoUsuario.getPassword2())) {
            String uri;
            try {
                MultipartFile thumbnail = imageScaler.resizeAvatarImage(foto);
                uri = fileService.save(thumbnail);
            } catch (Exception ex) {
                throw new Exception("Error al subir la imagen de perfil");
            }

            Usuario usuario = Usuario.builder()
                    .password(passwordEncoder.encode(nuevoUsuario.getPassword()))
                    .apellidos(nuevoUsuario.getApellidos())
                    .foto(uri)
                    .email(nuevoUsuario.getEmail())
                    .nombre(nuevoUsuario.getNombre())
                    .rol(UserRole.ADMINISTRADOR)
                    .build();
            return save(usuario);
        } else {
            return null;
        }
    }
}
