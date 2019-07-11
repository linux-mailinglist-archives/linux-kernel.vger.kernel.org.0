Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E93CF656CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 14:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfGKM0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 08:26:21 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58401 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfGKM0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 08:26:21 -0400
Received: from 79.184.253.121.ipv4.supernova.orange.pl (79.184.253.121) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 713904bb2616ada4; Thu, 11 Jul 2019 14:26:18 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     wen.yang99@zte.com.cn
Cc:     sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: linux-next: build warning after merge of the pm tree
Date:   Thu, 11 Jul 2019 14:26:18 +0200
Message-ID: <16643843.udE4Cbaid0@kreacher>
In-Reply-To: <201907111346291954773@zte.com.cn>
References: <201907111346291954773@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 11, 2019 7:46:29 AM CEST wen.yang99@zte.com.cn wrote:
> > Hi all,
> > 
> > After merging the pm tree, today's linux-next build (powerpc
> > ppc64_defconfig) produced this warning:
> > 
> > drivers/cpufreq/pasemi-cpufreq.c: In function 'pas_cpufreq_cpu_init':
> > drivers/cpufreq/pasemi-cpufreq.c:199:1: warning: label 'out_unmap_sdcpwr' defined but not used [-Wunused-label]
> > out_unmap_sdcpwr:
> > ^~~~~~~~~~~~~~~~
> > 
> > Introduced by commit
> > 
> > f43e075f7252 ("cpufreq/pasemi: fix an use-after-free in pas_cpufreq_cpu_init()")
> 
> Thank you very much.
> 
> We need to delete the useless code here:
> diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> index 1f0beb7..624c34a 100644
> --- a/drivers/cpufreq/pasemi-cpufreq.c
> +++ b/drivers/cpufreq/pasemi-cpufreq.c
> @@ -195,9 +195,6 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
> 
>         return cpufreq_generic_init(policy, pas_freqs, get_gizmo_latency());
> 
> -out_unmap_sdcpwr:
> -       iounmap(sdcpwr_mapbase);
> -
>  out_unmap_sdcasr:
>         iounmap(sdcasr_mapbase);
>  out:

I'm dropping commit f43e075f7252 from my linux-next branch, so please send a new version
of that patch with the issue fixed.

If you consider alternatives to the patch, please describe them in the message section between
the patch and the changelog.



