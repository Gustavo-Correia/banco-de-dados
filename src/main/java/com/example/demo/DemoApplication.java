package com.example.demo;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DemoApplication {
	private static final Scanner sc = new Scanner(System.in);
	public static void main(String[] args) {
		try (Connection conn = Conexao.getConnection()) {
            System.out.println("Conectado com sucesso ao SQL Server!");
        } catch (SQLException e) {
            e.printStackTrace();
        }

		int opcao;
        do {
            System.out.println("\n===== MENU =====");
            System.out.println("1 - Cadastrar Paciente");
            System.out.println("2 - Cadastrar Médico");
            System.out.println("3 - Listar Pacientes");
            System.out.println("4 - Listar Médicos");
            System.out.println("0 - Sair");
            System.out.print("Escolha uma opção: ");
            opcao = sc.nextInt();
            sc.nextLine(); // consumir quebra de linha

            switch (opcao) {
                case 1 -> cadastrarPaciente();
                case 2 -> cadastrarMedico();
                case 3 -> listarPacientes();
                case 4 -> listarMedicos();
                case 0 -> System.out.println("Saindo...");
                default -> System.out.println("Opção inválida!");
            }

        } while (opcao != 0);

		SpringApplication.run(DemoApplication.class, args);
	}
	private static void cadastrarPaciente() {
        System.out.print("Nome: ");
        String nome = sc.nextLine();
        System.out.print("CPF: ");
        String cpf = sc.nextLine();
        System.out.print("Data de nascimento (YYYY-MM-DD): ");
        String data = sc.nextLine();
        System.out.print("Endereço: ");
        String endereco = sc.nextLine();
        System.out.print("Telefone: ");
        String telefone = sc.nextLine();
        System.out.print("Email: ");
        String email = sc.nextLine();

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
            System.out.println("Paciente cadastrado com sucesso!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void cadastrarMedico() {
        System.out.print("CRM: ");
        String crm = sc.nextLine();
        System.out.print("Nome: ");
        String nome = sc.nextLine();
        System.out.print("CPF: ");
        String cpf = sc.nextLine();
        System.out.print("Especialidade: ");
        String especialidade = sc.nextLine();
        System.out.print("Forma de contato: ");
        String contato = sc.nextLine();

        String sql = "INSERT INTO Medicos (crm, nome, cpf, especialidade, forma_contato) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = Conexao.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, crm);
            stmt.setString(2, nome);
            stmt.setString(3, cpf);
            stmt.setString(4, especialidade);
            stmt.setString(5, contato);
            stmt.executeUpdate();
            System.out.println("Médico cadastrado com sucesso!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void listarPacientes() {
        String sql = "SELECT id_paciente, nome, cpf, data_nascimento, endereco, telefone, email FROM Paciente";

        try (Connection conn = Conexao.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            System.out.println("\n--- Lista de Pacientes ---");
            while (rs.next()) {
                System.out.printf("%d | %s | %s | %s | %s | %s | %s%n",
                        rs.getInt("id_paciente"),
                        rs.getString("nome"),
                        rs.getString("cpf"),
                        rs.getDate("data_nascimento"),
                        rs.getString("endereco"),
                        rs.getString("telefone"),
                        rs.getString("email"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void listarMedicos() {
        String sql = "SELECT crm, nome, cpf, especialidade, forma_contato FROM Medicos";

        try (Connection conn = Conexao.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            System.out.println("\n--- Lista de Médicos ---");
            while (rs.next()) {
                System.out.printf("%s | %s | %s | %s | %s%n",
                        rs.getString("crm"),
                        rs.getString("nome"),
                        rs.getString("cpf"),
                        rs.getString("especialidade"),
                        rs.getString("forma_contato"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
