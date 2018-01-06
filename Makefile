# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ahamouda <ahamouda@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2016/02/27 01:48:43 by ahamouda          #+#    #+#              #
#    Updated: 2017/12/22 21:04:03 by ahamouda         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

## Basics.

NAME =

CC = clang

RM = rm -f

## Flags.

CFLAGS = -Wall -Werror -Wextra -Weverything

#SFLAGS = -Weverything
#OFLAGS = -O3 -march=native
#DFLAGS = -g3 -fsanitize=address

## Lib/Header.

HEADER_PATH = ./Includes

HEADER_FILE =

HEADER = $(HEADER_FILE:%.h=$(HEADER_PATH)/%.h)

#LIB = ./malloc.a

LINKER = -I $(HEADER_PATH) ./Libftprintf/includes -L ./Libftprintf/ -lftprintf

## Objects/Sources.


OBJ_PATH = Objects
OBJECTS = $(addprefix $(OBJ_PATH)/, $(SRC:%.c=%.o))

SRC_PATH = ./Sources
SRC_SUBDIR += .

SRC =

vpath %.c $(addprefix $(SRC_PATH)/,$(SRC_SUBDIR))

#.SILENT:

all : $(NAME)

$(NAME) : $(OBJECTS)
	Make -C Libftprintf
	$(CC) -o $@ $^ $(LINKER)

$(OBJECTS): $(HEADERS) | $(OBJ_PATH)

$(OBJECTS): $(OBJ_PATH)/%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS) -I$(HEADER_PATH)

$(OBJ_PATH):
	@-mkdir -p $@

clean:
	Make -C Libftprintf clean
	$(RM) -r $(OBJ_PATH)

fclean: clean
	make -C Libftprintf fclean
	$(RM) $(NAME) $(LINK)

re: fclean all

norme:
	-@ ! norminette -R CheckTopCommentHeader $(SRC_PATH) | grep -v -B 1 "^Norme" || true
	-@ ! norminette -R CheckTopCommentHeader $(HEADER_PATH) | grep -v -B 1 "^Norme" || true

watch:
	watch "make norme" "50"

function:
	nm -u $(NAME)

.PHONY: re fclean clean norme watch function
