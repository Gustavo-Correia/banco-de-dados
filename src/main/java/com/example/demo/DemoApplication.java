package com.example.demo;
import javafx.application.Application;
import javafx.scene.Scene;
import javafx.stage.Stage;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;
import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.stage.Stage;
import java.util.Optional;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


//   ./mvnw clean compile exec:java          (Executar programa)

@SpringBootApplication
public class DemoApplication extends Application {

    public static void main(String[] args) {
        
        launch(args); // inicia JavaFX
        // SpringApplication.run(DemoApplication.class, args); // Removido pois não está sendo usado
    }

    @Override
    public void start(Stage primaryStage) {
        try (Connection conn = Conexao.getConnection()) {
            System.out.println("Conectado com sucesso ao SQL Server!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        primaryStage.setTitle("Sistema da Clínica");

        Button btnCadastrarPaciente = new Button("Cadastrar Paciente");
        Button btnCadastrarMedico = new Button("Cadastrar Médico");
        Button btnListarPacientes = new Button("Listar Pacientes");
        Button btnListarMedicos = new Button("Listar Médicos");

        VBox layout = new VBox(15, btnCadastrarPaciente, btnCadastrarMedico, btnListarPacientes, btnListarMedicos);
        layout.setStyle("-fx-padding: 40; -fx-alignment: center; -fx-background-color: #f0f0f0;");
        layout.getChildren().forEach(node -> node.setStyle("-fx-font-size: 16px; -fx-pref-width: 250px;"));

        btnCadastrarPaciente.setOnAction(e -> mostrarCadastroPaciente());
        btnCadastrarMedico.setOnAction(e -> mostrarCadastroMedico());
        btnListarPacientes.setOnAction(e -> listarPacientes());
        btnListarMedicos.setOnAction(e -> listarMedicos());

        primaryStage.setScene(new Scene(layout, 400, 300));
        primaryStage.show();
    }

    private void mostrarCadastroPaciente() {
        Dialog<ButtonType> dialog = new Dialog<>();
        dialog.setTitle("Cadastro de Paciente");

        GridPane grid = new GridPane();
        grid.setVgap(10);
        grid.setHgap(10);
        grid.setStyle("-fx-padding: 20;");

        TextField nome = new TextField();
        TextField cpf = new TextField();
        TextField data = new TextField();
        TextField endereco = new TextField();
        TextField telefone = new TextField();
        TextField email = new TextField();

        grid.addRow(0, new Label("Nome:"), nome);
        grid.addRow(1, new Label("CPF:"), cpf);
        grid.addRow(2, new Label("Data Nasc. (YYYY-MM-DD):"), data);
        grid.addRow(3, new Label("Endereço:"), endereco);
        grid.addRow(4, new Label("Telefone:"), telefone);
        grid.addRow(5, new Label("Email:"), email);

        dialog.getDialogPane().setContent(grid);
        dialog.getDialogPane().getButtonTypes().addAll(ButtonType.OK, ButtonType.CANCEL);

        Optional<ButtonType> result = dialog.showAndWait();
        if (result.isPresent() && result.get() == ButtonType.OK) {
            cadastrarPaciente(
                    nome.getText(),
                    cpf.getText(),
                    data.getText(),
                    endereco.getText(),
                    telefone.getText(),
                    email.getText()
            );
        }
    }

    private void mostrarCadastroMedico() {
        Dialog<ButtonType> dialog = new Dialog<>();
        dialog.setTitle("Cadastro de Médico");

        GridPane grid = new GridPane();
        grid.setVgap(10);
        grid.setHgap(10);
        grid.setStyle("-fx-padding: 20;");

        TextField crm = new TextField();
        TextField nome = new TextField();
        TextField cpf = new TextField();
        TextField especialidade = new TextField();
        TextField contato = new TextField();

        grid.addRow(0, new Label("CRM:"), crm);
        grid.addRow(1, new Label("Nome:"), nome);
        grid.addRow(2, new Label("CPF:"), cpf);
        grid.addRow(3, new Label("Especialidade:"), especialidade);
        grid.addRow(4, new Label("Contato:"), contato);

        dialog.getDialogPane().setContent(grid);
        dialog.getDialogPane().getButtonTypes().addAll(ButtonType.OK, ButtonType.CANCEL);

        Optional<ButtonType> result = dialog.showAndWait();
        if (result.isPresent() && result.get() == ButtonType.OK) {
            cadastrarMedico(
                    crm.getText(),
                    nome.getText(),
                    cpf.getText(),
                    especialidade.getText(),
                    contato.getText()
            );
        }
    }

    private void cadastrarPaciente(String nome, String cpf, String data, String endereco, String telefone, String email) {
        String sql = "INSERT INTO Paciente (nome, cpf, data_nascimento, endereco, telefone, email) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = Conexao.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, nome);
            stmt.setString(2, cpf);
            stmt.setDate(3, Date.valueOf(data));
            stmt.setString(4, endereco);
            stmt.setString(5, telefone);
            stmt.setString(6, email);
            stmt.executeUpdate();
            showAlert("Sucesso", "Paciente cadastrado com sucesso!");
        } catch (SQLException e) {
            showAlert("Erro", "Erro ao cadastrar paciente:\n" + e.getMessage());
        }
    }

    private void cadastrarMedico(String crm, String nome, String cpf, String especialidade, String contato) {
        String sql = "INSERT INTO Medicos (crm, nome, cpf, especialidade, forma_contato) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = Conexao.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, crm);
            stmt.setString(2, nome);
            stmt.setString(3, cpf);
            stmt.setString(4, especialidade);
            stmt.setString(5, contato);
            stmt.executeUpdate();
            showAlert("Sucesso", "Médico cadastrado com sucesso!");
        } catch (SQLException e) {
            showAlert("Erro", "Erro ao cadastrar médico:\n" + e.getMessage());
        }
    }

    private void listarPacientes() {
        String sql = "SELECT id_paciente, nome, cpf, data_nascimento, endereco, telefone, email FROM Paciente";
        StringBuilder sb = new StringBuilder();

        try (Connection conn = Conexao.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            sb.append("Lista de Pacientes:\n\n");
            while (rs.next()) {
                sb.append(String.format("%d | %s | %s | %s | %s | %s | %s\n",
                        rs.getInt("id_paciente"),
                        rs.getString("nome"),
                        rs.getString("cpf"),
                        rs.getDate("data_nascimento"),
                        rs.getString("endereco"),
                        rs.getString("telefone"),
                        rs.getString("email")));
            }

        } catch (SQLException e) {
            sb.append("Erro ao listar pacientes: ").append(e.getMessage());
        }

        showTextDialog("Pacientes", sb.toString());
    }

    private void listarMedicos() {
        String sql = "SELECT crm, nome, cpf, especialidade, forma_contato FROM Medicos";
        StringBuilder sb = new StringBuilder();

        try (Connection conn = Conexao.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            sb.append("Lista de Médicos:\n\n");
            while (rs.next()) {
                sb.append(String.format("%s | %s | %s | %s | %s\n",
                        rs.getString("crm"),
                        rs.getString("nome"),
                        rs.getString("cpf"),
                        rs.getString("especialidade"),
                        rs.getString("forma_contato")));
            }

        } catch (SQLException e) {
            sb.append("Erro ao listar médicos: ").append(e.getMessage());
        }

        showTextDialog("Médicos", sb.toString());
    }

    private void showAlert(String title, String message) {
        Alert alert = new Alert(Alert.AlertType.INFORMATION);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.showAndWait();
    }

    private void showTextDialog(String title, String content) {
        TextArea textArea = new TextArea(content);
        textArea.setEditable(false);
        textArea.setWrapText(true);
        textArea.setPrefHeight(400);
        textArea.setPrefWidth(600);

        Dialog<Void> dialog = new Dialog<>();
        dialog.setTitle(title);
        dialog.getDialogPane().setContent(textArea);
        dialog.getDialogPane().getButtonTypes().add(ButtonType.CLOSE);
        dialog.showAndWait();
    }
}