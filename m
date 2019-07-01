Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1AA1A278
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 19:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfEJRh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 13:37:57 -0400
Received: from foss.arm.com ([217.140.101.70]:53796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfEJRhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:37:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B605A78;
        Fri, 10 May 2019 10:37:55 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B38613F6C4;
        Fri, 10 May 2019 10:37:52 -0700 (PDT)
Date:   Fri, 10 May 2019 18:37:48 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "Arshiya Hayatkhan Pathan" <arshiya.hayatkhan.pathan@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        James Morse <James.Morse@arm.com>
Subject: Re: [PATCH v7 07/13] selftests/resctrl: Add MBA test
Message-ID: <20190510183748.0a5d5c7a@donnerap.cambridge.arm.com>
In-Reply-To: <1549767042-95827-8-git-send-email-fenghua.yu@intel.com>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
        <1549767042-95827-8-git-send-email-fenghua.yu@intel.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Feb 2019 18:50:36 -0800
Fenghua Yu <fenghua.yu@intel.com> wrote:

Hi,

> From: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
> 
> MBA (Memory Bandwidth Allocation) test starts a stressful memory
> bandwidth benchmark and allocates memory bandwidth from 100% down
> to 10% for the benchmark process. For each allocation, compare
> perf IMC counter and mbm total bytes from resctrl. The difference
> between the two values should be within a threshold to pass the test.
> 
> Default benchmark is built-in fill_buf. But users can specify their
> own benchmark by option "-b".
> 
> We can add memory bandwidth allocation for multiple processes in the
> future.
> 
> Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  tools/testing/selftests/resctrl/Makefile        |   2 +-
>  tools/testing/selftests/resctrl/mba_test.c      | 177 ++++++++++++++++++++++++
>  tools/testing/selftests/resctrl/resctrl.h       |   2 +
>  tools/testing/selftests/resctrl/resctrl_tests.c |  15 +-
>  4 files changed, 194 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/resctrl/mba_test.c
> 
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index eaa8b45de10d..141cbdb619af 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -8,7 +8,7 @@ all: resctrl_tests
>  
>  resctrl_tests: *.o
>  	$(CC) $(CFLAGS) -o resctrl_tests resctrl_tests.o resctrlfs.o \
> -		 resctrl_val.o fill_buf.o mbm_test.o
> +		 resctrl_val.o fill_buf.o mbm_test.o mba_test.o
>  
>  .PHONY: clean
>  
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> new file mode 100644
> index 000000000000..71d8feb93ac8
> --- /dev/null
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Memory Bandwidth Allocation (MBA) test
> + *
> + * Copyright (C) 2018 Intel Corporation
> + *
> + * Authors:
> + *    Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
> + *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
> + *    Fenghua Yu <fenghua.yu@intel.com>
> + */
> +#include "resctrl.h"
> +
> +#define RESULT_FILE_NAME	"result_mba"
> +#define NUM_OF_RUNS		5
> +#define MAX_DIFF		300

What is the unit here? MB/s?

> +#define ALLOCATION_MAX		100
> +#define ALLOCATION_MIN		10
> +#define ALLOCATION_STEP		10
> +
> +/*
> + * Change schemata percentage from 100 to 10%. Write schemata to specified
> + * con_mon grp, mon_grp in resctrl FS.
> + * For each allocation, run 5 times in order to get average values.
> + */
> +static int mba_setup(int num, ...)
> +{
> +	static int runs_per_allocation, allocation = 100;
> +	struct resctrl_val_param *p;
> +	char allocation_str[64];
> +	va_list param;
> +
> +	va_start(param, num);
> +	p = va_arg(param, struct resctrl_val_param *);
> +	va_end(param);
> +
> +	if (runs_per_allocation >= NUM_OF_RUNS)
> +		runs_per_allocation = 0;
> +
> +	/* Only set up schemata once every NUM_OF_RUNS of allocations */
> +	if (runs_per_allocation++ != 0)
> +		return 0;
> +
> +	if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
> +		return -1;
> +
> +	sprintf(allocation_str, "%d", allocation);
> +
> +	write_schemata(p->ctrlgrp, allocation_str, p->cpu_no, p->resctrl_val);
> +	printf("changed schemata to : %d\n", allocation);
> +	allocation -= ALLOCATION_STEP;
> +
> +	return 0;
> +}
> +
> +static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
> +{
> +	int allocation, failed = 0, runs;
> +
> +	/* Memory bandwidth from 100% down to 10% */
> +	for (allocation = 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
> +	     allocation++) {
> +		unsigned long avg_bw_imc = 0, avg_bw_resc = 0;

No need to initialise those.

> +		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
> +		long  avg_diff = 0;

... and this one.

> +
> +		/*
> +		 * The first run is discarded due to inaccurate value from
> +		 * phase transition.
> +		 */
> +		for (runs = NUM_OF_RUNS * allocation + 1;
> +		     runs < NUM_OF_RUNS * allocation + NUM_OF_RUNS ; runs++) {
> +			sum_bw_imc += bw_imc[runs];
> +			sum_bw_resc += bw_resc[runs];
> +		}
> +
> +		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
> +		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
> +		avg_diff = avg_bw_resc - avg_bw_imc;

Same comment as in the last patch: use labs() here already.

Cheers,
Andre.

> +
> +		printf("\nschemata percentage: %d \t",
> +		       ALLOCATION_MAX - ALLOCATION_STEP * allocation);
> +		printf("avg_bw_imc: %lu\t", avg_bw_imc);
> +		printf("avg_bw_resc: %lu\t", avg_bw_resc);
> +		printf("avg_diff: %lu\t", labs(avg_diff));
> +		if (labs(avg_diff) > MAX_DIFF) {
> +			printf("failed\n");
> +			failed = 1;
> +		} else {
> +			printf("passed\n");
> +		}
> +	}
> +
> +	if (failed) {
> +		printf("\nTest for schemata change using MBA failed");
> +		printf("as atleast one test failed!\n");
> +	} else {
> +		printf("\nTests for changing schemata using MBA passed!\n\n");
> +	}
> +}
> +
> +static int check_results(void)
> +{
> +	char *token_array[8], output[] = RESULT_FILE_NAME, temp[512];

The size of temp[] does not match below the usage ...

> +	unsigned long bw_imc[1024], bw_resc[1024];
> +	int runs;
> +	FILE *fp;
> +
> +	printf("\nchecking for pass/fail\n");
> +	fp = fopen(output, "r");
> +	if (!fp) {
> +		perror("Error in opening file\n");
> +
> +		return errno;
> +	}
> +
> +	runs = 0;
> +	while (fgets(temp, 1024, fp)) {

... here. You could just use sizeof(temp) here.

> +		char *token = strtok(temp, ":\t");
> +		int fields = 0;
> +
> +		while (token) {
> +			token_array[fields++] = token;
> +			token = strtok(NULL, ":\t");
> +		}
> +
> +		/* Field 3 is perf imc value */
> +		bw_imc[runs] = strtoul(token_array[3], NULL, 0);
> +		/* Field 5 is resctrl value */
> +		bw_resc[runs] = strtoul(token_array[5], NULL, 0);
> +		runs++;
> +	}
> +
> +	fclose(fp);
> +
> +	show_mba_info(bw_imc, bw_resc);
> +
> +	return 0;
> +}
> +
> +void mba_test_cleanup(void)
> +{
> +	remove(RESULT_FILE_NAME);
> +}
> +
> +int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
> +{
> +	struct resctrl_val_param param = {
> +		.resctrl_val	= "mba",
> +		.ctrlgrp	= "c1",
> +		.mongrp		= "m1",
> +		.cpu_no		= cpu_no,
> +		.mum_resctrlfs	= 1,
> +		.filename	= RESULT_FILE_NAME,
> +		.bw_report	= bw_report,
> +		.setup		= mba_setup
> +	};
> +	int ret;
> +
> +	remove(RESULT_FILE_NAME);
> +
> +	ret = validate_resctrl_feature_request("mba");
> +	if (ret)
> +		return ret;
> +
> +	ret = resctrl_val(benchmark_cmd, &param);
> +	if (ret)
> +		return ret;
> +
> +	ret = check_results();
> +	if (ret)
> +		return ret;
> +
> +	mba_test_cleanup();
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 7f7ea180478c..92e5f2930c68 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -74,5 +74,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
>  int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd);
>  void tests_cleanup(void);
>  void mbm_test_cleanup(void);
> +int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
> +void mba_test_cleanup(void);
>  
>  #endif /* RESCTRL_H */
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index a51780d28ff1..5fbfa8685b58 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -27,6 +27,7 @@ static void cmd_help(void)
>  void tests_cleanup(void)
>  {
>  	mbm_test_cleanup();
> +	mba_test_cleanup();
>  }
>  
>  int main(int argc, char **argv)
> @@ -34,7 +35,7 @@ int main(int argc, char **argv)
>  	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
>  	int res, c, cpu_no = 1, span = 250, argc_new = argc, i;
>  	int ben_ind;
> -	bool has_ben = false, mbm_test = true;
> +	bool has_ben = false, mbm_test = true, mba_test = true;
>  	char *benchmark_cmd[BENCHMARK_ARGS];
>  	char bw_report[64], bm_type[64];
>  
> @@ -55,9 +56,12 @@ int main(int argc, char **argv)
>  			token = strtok(optarg, ",");
>  
>  			mbm_test = false;
> +			mba_test = false;
>  			while (token) {
>  				if (!strcmp(token, "mbm")) {
>  					mbm_test = true;
> +				} else if (!strcmp(token, "mba")) {
> +					mba_test = true;
>  				} else {
>  					printf("invalid argument\n");
>  
> @@ -110,5 +114,14 @@ int main(int argc, char **argv)
>  			printf("Error in running tests for mbm bw change!\n");
>  	}
>  
> +	if (mba_test) {
> +		printf("\nMBA Schemata Change Starting..\n");
> +		if (!has_ben)
> +			sprintf(benchmark_cmd[1], "%d", span);
> +		res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
> +		if (res)
> +			printf("Error in tests for mba-change-schemata!\n");
> +	}
> +
>  	return 0;
>  }

