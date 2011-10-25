class Grafo
	
	def initialize
		@matriz_adj = []
		@vertices = []
		@count = 0
		@count_ant = 0
		@vertices_menor_peso = []
		@vertices_verificados = []
		self.get_entrada
	end
	
# Funcoes p ler a entrada

	def get_entrada
		entrada = gets

		@quantidades = []
		numero = ""
		
		entrada.each_char do |x|
			if x == " " || x == "\n"
				@quantidades << numero
				numero = ""
			else
				numero << x
			end
		end

		self.get_passagens
	end
	
	def get_passagens
		@linhas = []
		@quantidades[1].to_i.times do 
			@linhas << gets
		end
		
		@linhas.each do |linha|
			vertices = []
			entrada = ""
			linha.each_char do |x|
				if x == " " || x == "\n"
					vertices << entrada
					entrada = ""
				else
					entrada << x
				end
			end
			
			self.add_vertice vertices[0]
			self.add_vertice vertices[1]
			self.add_aresta vertices[0],vertices[1],vertices[2]
		end
		
		puts self.maxima_passagem_minima
	end
	
# Implementacao do grafo

	def add_vertice v
		return nil if @vertices.index(v)
		@matriz_adj << Array.new
		@vertices << v
	end
	
	def add_aresta u,v,p
		p = p.to_i
		u = @vertices.index(u)
		v = @vertices.index(v)
		@matriz_adj[u][v] = p

		#self.condicao_inicial p
		if @count == 0
			@menor_peso = p
			@count += 1
		end
		self.menor_peso u,v,p
	end
	
	def visualiza
		@vertices.each_index do |i|
			@matriz_adj[i].each_index do |j|
				puts i.to_s << " " << j.to_s
				puts @matriz_adj[i][j]
			end
		end
	end
	
#Implementacao solucao	do problema

	def condicao_inicial p
		if @count == @count_ant
			@menor_peso = p
			@count += 1
			@vertices_menor_peso = []
			puts @count
		end
	end
	
	def menor_peso u,v,p
		if @menor_peso > p
			@menor_peso = p
			@vertices_menor_peso = []
		end
		
		if @menor_peso == p
			@vertices_menor_peso << u if !@vertices_menor_peso.index(u)
			@vertices_menor_peso << v if !@vertices_menor_peso.index(v) 
		end	
	end
	
	def maxima_passagem_minima
		@vertices_menor_peso.each do |menor|
			@vertices_verificados << @vertices[menor] if !@vertices_verificados.index(@vertices[menor])
		end
		self.busca_prox_menor_peso
	end
	
	def busca_prox_menor_peso
		return @menor_peso if @vertices_verificados.size == @vertices.size
		
		self.retira_arestas_verificadas
		
		@count_ant += 1

		@vertices.size.times do |i|
			@matriz_adj[i].size.times do |j|
				if @matriz_adj[i][j] != nil
					if @count == 1
						@menor_peso = @matriz_adj[i][j]
						@count += 1
						@vertices_menor_peso = []
					end
					
					self.condicao_inicial @matriz_adj[i][j]
					self.menor_peso i, j, @matriz_adj[i][j]	
				end	
			end
		end
		
		self.maxima_passagem_minima
	end
	
	def retira_arestas_verificadas
		@vertices_verificados.each do |i|
			i = @vertices.index(i)
			@matriz_adj[i].size.times do |j|
				@matriz_adj[i][j] = nil if @matriz_adj[i][j] == @menor_peso
			end
		end
	end
	
end

grafo = Grafo.new

#grafo.visualiza
