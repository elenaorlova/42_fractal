/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   open_cl_error.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bshanae <bshanae@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/06/28 15:18:13 by bshanae           #+#    #+#             */
/*   Updated: 2019/06/29 16:46:28 by bshanae          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "open_cl.h"

void				error_raise(int line, const char *function_name, int error)
{
	ft_printf("Error no. %d on line %d in %s\n", error, line, function_name);
	exit(1);
}

void				error_check(int line, const char *function_name, int error)
{
	if (error < 0)
		error_raise(line, function_name, error);
}

void				error_log(t_open_cl *me, cl_program *program, int error)
{
	char			*log;
	u_long			log_length;

	clGetProgramBuildInfo(*program, me->gpu,
		CL_PROGRAM_BUILD_LOG, 0, NULL, &log_length);
	log = ft_strnew(log_length);
	clGetProgramBuildInfo(*program, me->gpu,
		CL_PROGRAM_BUILD_LOG, log_length + 1, log, NULL);
	ft_printf("LOG (%d): \n%s\n", error, log);
	free(log);
	exit(1);
}
