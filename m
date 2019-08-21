Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4714B97045
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 05:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfHUDZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 23:25:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44883 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfHUDZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:25:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so514356plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 20:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=FKWAkiDR5rSbbJHylgJX/d3UkhUAaJmc1tNEs5aP4JU=;
        b=CI21+U4nsmf7wBi8MX/lwJOeIz5A1WSv9OwVMFI4pPUD57NxZftzFB7n+uG+jcdnap
         7Glvco1VzzG0sp+eNaIgQJSrVEwLUhqbQQhap97rg2pMUAET36gee6KdYCFg+hSZsrh5
         DlBUC9OgKHP+wv1njj0zDgd/l1ClTMK1YCNfVaHcXbmZispBCRtz1T4GZZTOfWUF8uIn
         f9x/v79LEMyYOJbkz/rIiDtTMPzr4WgvI9M/kBI6/Tkz0PwTdmOQ4QIFDO07UsgUd0Wc
         O/JDhZHow5uv5sEVcx1PPobeCrnB5L1jCRsiVC7sj2II3lJRMLwT8GV61PDrfxS3GhYY
         crYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=FKWAkiDR5rSbbJHylgJX/d3UkhUAaJmc1tNEs5aP4JU=;
        b=OzZ5yh7xuZuLn7ClCRfJlyiFCfrsaTsN3Qd7kL1w5AApGPB5CL6Srelit4cjJ8zTJg
         G34sO85Hf4tmDFeJE5AL7fvWT12YQVHyJX4jZlvpcvZVyZbD6bzGGOY5ahXZyOtqN3Hf
         WJQyjy8MlHg/vlvhsx7w3IcUToVAbHeSsJXKdU6fyLe+gSbaSSJPVuEBKx2XI/RCV/z4
         4xhdsvQ7URI8y5dYa9H24YcXrt9RVVXuqarPTxuM1b5LAYwzhqIoBWiwBKZyN7fv6YsO
         UG68Uo4VdSlZIT6pC2qdI5wS0QKzGsXrDRgkANAIEo3FJGHtjQt0odNqHXTgIFlGNyvc
         g3oA==
X-Gm-Message-State: APjAAAXA1ccGE03P2I2vLsXkCB5CuFUWxhE2p85kCkZ8N6y6OIcFPJPG
        KaFFwllf/o2Hf+gMYIJ4ufXwYQ==
X-Google-Smtp-Source: APXvYqw7T3zbmDwzrqn0BLzf5Ac0Hjt+YjaptvIvR3GtFvAskUNeAmq+ZSMDpdGW6UVBL/ff7IiwZw==
X-Received: by 2002:a17:902:5a42:: with SMTP id f2mr32046957plm.45.1566357934258;
        Tue, 20 Aug 2019 20:25:34 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e13sm26285977pfl.130.2019.08.20.20.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 20:25:33 -0700 (PDT)
Date:   Tue, 20 Aug 2019 20:25:32 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Edward Chron <echron@arista.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, colona@arista.com
Subject: Re: [PATCH] mm/oom: Add oom_score_adj value to oom Killed process
 message
In-Reply-To: <20190821001445.32114-1-echron@arista.com>
Message-ID: <alpine.DEB.2.21.1908202024300.141379@chino.kir.corp.google.com>
References: <20190821001445.32114-1-echron@arista.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019, Edward Chron wrote:

> For an OOM event: print oom_score_adj value for the OOM Killed process to
> document what the oom score adjust value was at the time the process was
> OOM Killed. The adjustment value can be set by user code and it affects
> the resulting oom_score so it is used to influence kill process selection.
> 
> When eligible tasks are not printed (sysctl oom_dump_tasks = 0) printing
> this value is the only documentation of the value for the process being
> killed. Having this value on the Killed process message documents if a
> miscconfiguration occurred or it can confirm that the oom_score_adj
> value applies as expected.
> 
> An example which illustates both misconfiguration and validation that
> the oom_score_adj was applied as expected is:
> 
> Aug 14 23:00:02 testserver kernel: Out of memory: Killed process 2692
>  (systemd-udevd) total-vm:1056800kB, anon-rss:1052760kB, file-rss:4kB,
>  shmem-rss:0kB oom_score_adj:1000
> 
> The systemd-udevd is a critical system application that should have an
> oom_score_adj of -1000. Here it was misconfigured to have a adjustment
> of 1000 making it a highly favored OOM kill target process. The output
> documents both the misconfiguration and the fact that the process
> was correctly targeted by OOM due to the miconfiguration. Having
> the oom_score_adj on the Killed message ensures that it is documented.
> 
> Signed-off-by: Edward Chron <echron@arista.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: David Rientjes <rientjes@google.com>

vm.oom_dump_tasks is pretty useful, however, so it's curious why you 
haven't left it enabled :/

> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index eda2e2a0bdc6..c781f73b6cd6 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -884,12 +884,13 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  	 */
>  	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
>  	mark_oom_victim(victim);
> -	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
> +	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB oom_score_adj:%ld\n",
>  		message, task_pid_nr(victim), victim->comm,
>  		K(victim->mm->total_vm),
>  		K(get_mm_counter(victim->mm, MM_ANONPAGES)),
>  		K(get_mm_counter(victim->mm, MM_FILEPAGES)),
> -		K(get_mm_counter(victim->mm, MM_SHMEMPAGES)));
> +		K(get_mm_counter(victim->mm, MM_SHMEMPAGES)),
> +		(long)victim->signal->oom_score_adj);
>  	task_unlock(victim);
>  
>  	/*

Nit: why not just use %hd and avoid the cast to long?
