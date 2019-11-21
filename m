Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2241051E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 12:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKUL4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 06:56:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36086 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUL4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:56:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so4060018wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 03:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9s0Szgje6dpjr0n1pOVioXKzl3AXPEDnWb0L/NtVhy8=;
        b=YOqA8iRATXa4hiQpcuWEo88UUFOhYt04+y39MAUSbsFkYjXU/7A1l92XdZTpjszuVR
         kgjfL/m1n0J/JqUDeJzUP8WbAiODQ7PmzfW7KbOWpHCwjxGycqwkc+cveckxzaF12fcb
         POJfMrMzdHAjWp8lZaawCDOOT1cxn/iI1q/hSGSQZ7po7sSYziEoCmMLiTXrwnDRwZCS
         HEUytpO3v01RIVBWusmqNQqkce5PFcBDUG7yL6Gr/wXkSnkWurGrIZESZsIUOo077yS/
         6hXQMb+wI37IFti1iZZxiZViP7ByC8DBVVY/jkrS0YJ2JiJ9p++9iB4wE5VFpFVsb6/C
         AmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9s0Szgje6dpjr0n1pOVioXKzl3AXPEDnWb0L/NtVhy8=;
        b=oEfjmXaIqJgHNL06whSM5C+yvIMRf7I6S/00lnrFQz2TDHqHarKZxRLNaePykQ8Wu0
         ly/V9dcRo7JSd6VgPOQkx/8BvDnYuDjBbYIESRsEPsmCObZrazDIhYDjbrnLu/3HqiHA
         6+YZHLiJ8TE9VB/lZLXONLfjVEctmfbfLOQEcp+TsQV6QqmZKNAaK7zWtmWAdAIvYWTY
         7UmRcFqkv7stOi4vyYoReQzXHmOQmSuzifZ3FA3aL1CJ1YatySTPNIFXyFBUck5GIkjw
         oxheUCvwWrO+I43sHAnOYAyi2eu8ORnReYBkkiK4XlsSdsiALcCPAsBGp6ubw3czPr/I
         TQ1g==
X-Gm-Message-State: APjAAAVVZfZvpgB7r/Bj2lcJpv6wPMCyhe+ACydEa5oaEGAw5cylFL6C
        9V296Fpf/xvv6q4fPOj59BZALA==
X-Google-Smtp-Source: APXvYqz3fNLfaGGdec9/pzJD6ZwR2e0KkKVgt3mwXRQxDQHhz+Y/ljjCJjoa474G1YOVNmadbxRcpg==
X-Received: by 2002:adf:c649:: with SMTP id u9mr10576080wrg.20.1574337366018;
        Thu, 21 Nov 2019 03:56:06 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id m1sm3132668wrv.37.2019.11.21.03.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 03:56:05 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:56:02 +0000
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH 3/3] sched/fair: Consider uclamp for "task fits capacity"
 checks
Message-ID: <20191121115602.GA213296@google.com>
References: <20191120175533.4672-1-valentin.schneider@arm.com>
 <20191120175533.4672-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120175533.4672-4-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 Nov 2019 at 17:55:33 (+0000), Valentin Schneider wrote:
> +static inline
> +unsigned long uclamp_task_util(struct task_struct *p, unsigned long util)

This 'util' parameter is always task_util_est(p) right ? You might want
to remove it.

> +{
> +	return clamp(util,
> +		     (unsigned long)uclamp_eff_value(p, UCLAMP_MIN),
> +		     (unsigned long)uclamp_eff_value(p, UCLAMP_MAX));
> +}

Thanks,
Quentin
