Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4130F11BF61
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 22:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLKVop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 16:44:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33248 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLKVop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:44:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so21369pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 13:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wkoNjmei5sIfxNKYIytd7zHyeLv+b+a83ECcT+r0WWE=;
        b=eQhg4POUvSGfKDGmAfB3LhOnH9J0IJrxgIKZW7BGANMGUuByHKI+JnZLshJIG0WwcC
         V5XHdW9lyQ0MxV4oCh5vmk6QOnMheyWSd7MtrBaQHzvG2phA2M+va7PryK+uMB/BaSC1
         JVWjqwGDON2r046aP2D7HY9T/KlpEDvS7obk3LFAZSBSudOxMJvscBD73p+L02Li55xF
         dmlNUnmolqzRBTmLtafIo/dt1oBuYT5nyE2kXVQNrbWoaowAaA5J+QAgxVr49uGPT8sR
         AaOoPPhahDkiwf2miU8uH2JKMezkJfZyWM0/ojhYFkbC62EPJia6RoaCK0Oy74n9WXMU
         zJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wkoNjmei5sIfxNKYIytd7zHyeLv+b+a83ECcT+r0WWE=;
        b=RaoymNurZzyhC2KYsrjRR7xg7mOA0TT5nDX+AlNfHXzglU7D9y+4mSkqX30XjEiUOL
         Q5MxR0jJl5UVcCwWDHLeU/1ufQKY19waRfpyt0VGjEcX8k/6sEuZSijgxgV7pasHf7VD
         5vGZ8UWPATTmHphhLh1eduwP/jZE1GZ2faURLXFLQvDv8Z9JjD7Wimh3gnle3BbrkvOD
         axBd5dYaMoX9NduNTMsRhWGiL1x3xeVBeIzcJnQb1qJz+wcMXj6Z96NAVY/Zm7g6vgUU
         6HN/u/il+L7ba6tvfNNFJ4zeHzlLZUNdbNfLUspIVgamMo9iLRPnM9zEgpQlQwpCWitK
         MK8Q==
X-Gm-Message-State: APjAAAWa3YbIRI1/IaHHJU1a5trwnKGGNucSpPAWhG7/hdUGCy+PrXIH
        nyJmzAiQDgIeDgVl1Z8XOTI8og==
X-Google-Smtp-Source: APXvYqw05tLSLBYBI71/bzNSgwOhxYrohKf19gPgNhSmYuZNKVWRhCaiynvJ1ckIYvm66/35qDD51Q==
X-Received: by 2002:a62:7541:: with SMTP id q62mr6091794pfc.256.1576100684673;
        Wed, 11 Dec 2019 13:44:44 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y38sm3951314pgk.33.2019.12.11.13.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 13:44:43 -0800 (PST)
Date:   Wed, 11 Dec 2019 13:44:43 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Ilya Dryomov <idryomov@gmail.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Edward Chron <echron@arista.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/oom: fix pgtables units mismatch in Killed process
 message
In-Reply-To: <20191211202830.1600-1-idryomov@gmail.com>
Message-ID: <alpine.DEB.2.21.1912111343050.97034@chino.kir.corp.google.com>
References: <20191211202830.1600-1-idryomov@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019, Ilya Dryomov wrote:

> pr_err() expects kB, but mm_pgtables_bytes() returns the number of
> bytes.  As everything else is printed in kB, I chose to fix the value
> rather than the string.
> 
> Before:
> 
> [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
> ...
> [   1878]  1000  1878   217253   151144  1269760        0             0 python
> ...
> Out of memory: Killed process 1878 (python) total-vm:869012kB, anon-rss:604572kB, file-rss:4kB, shmem-rss:0kB, UID:1000 pgtables:1269760kB oom_score_adj:0
> 
> After:
> 
> [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
> ...
> [   1436]  1000  1436   217253   151890  1294336        0             0 python
> ...
> Out of memory: Killed process 1436 (python) total-vm:869012kB, anon-rss:607516kB, file-rss:44kB, shmem-rss:0kB, UID:1000 pgtables:1264kB oom_score_adj:0
> 
> Fixes: 70cb6d267790 ("mm/oom: add oom_score_adj and pgtables to Killed process message")
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>

I'd also suggest a

Cc: stable@vger.kernel.org # 5.4
