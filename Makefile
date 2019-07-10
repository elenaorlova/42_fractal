NAME = fractol

INCL =										\
	./includes/camera/						\
	./includes/color/						\
	./includes/light/						\
	./includes/mlx/							\
	./includes/object/						\
    ./includes/easy/                        \
    ./includes/ikido/                       \
	./includes/open_cl/						\
	./includes/ray/							\
	./includes/rm/							\
	./includes/scene/						\
    ./includes/vector2/                     \
	./includes/vector3/						\
	./includes/vector4/

SRC =										\
	./sources/main.c                        \
    ./sources/camera/camera.c               \
    ./sources/easy/easy.c                   \
    ./sources/ikido/ikido.c                 \
    ./sources/mouse/mouse.c                 \
	./sources/object/object.c				\
	./sources/object/object_init_complex.c	\
	./sources/object/object_init_fractal.c	\
    ./sources/open_cl/open_cl.c             \
    ./sources/open_cl/open_cl_error.c       \
    ./sources/open_cl/open_cl_functions.c   \
    ./sources/open_cl/open_cl_init.c        \
    ./sources/rm/rm.c                       \
    ./sources/rm/rm_ctrl.c                  \
    ./sources/rm/rm_ctrl_easy.c             \
    ./sources/rm/rm_ctrl_ikido.c            \
    ./sources/rm/rm_mxl.c                   \
    ./sources/scene/scene.c                 \
    ./sources/vector3/vector3_a.c           \
    ./sources/vector3/vector3_b.c

OBJ_DIR = ./objects/
OBJ = $(addprefix $(OBJ_DIR),$(notdir $(SRC:.c=.o)))

GCC_LIBFT = -I ./libft/includes -L ./libft -l ft
GCC_WWW = -Wall -Werror -Wextra
GCC_MLX =									\
	-I /usr/local/include/					\
	-L /usr/local/lib/						\
	-l mlx									\
	-framework OpenGL -framework AppKit
GCC_OCL = -framework OpenCL

COMP_OBJ = gcc $(GCC_WWW) -I ./libft/includes/ $(addprefix -I, $(INCL))
COMP_BIN = gcc $(GCC_WWW) $(GCC_LIBFT) $(GCC_MLX) $(GCC_OCL)

define COMP_N_MOVE
	$(COMP_OBJ) -c $(1);
	mv $(notdir $(1:.c=.o)) $(addprefix $(OBJ_DIR),$(notdir $(1:.c=.o)));
endef

all : $(NAME)

$(NAME) : $(OBJ)
	@echo "doing some libft shit"
	@make -C ./libft
	$(COMP_BIN) $(OBJ) -o $(NAME)
	@echo "done :3"

$(OBJ) : $(SRC)
	@mkdir -p $(OBJ_DIR)
	@echo "I'm compiling objects, bro"
	$(foreach src,$(SRC), $(call COMP_N_MOVE, $(src)))

clean :
	rm -rf $(OBJ_DIR)
	make clean -C ./libft/

fclean :
	rm -rf $(OBJ_DIR)
	rm -rf $(NAME)
	make fclean -C ./libft/

re : fclean all

fast_re :
	@rm -rf $(OBJ_DIR)
	@rm -rf $(NAME)
	@$(MAKE) all

.PHONY : all clean fclean re fast_re
