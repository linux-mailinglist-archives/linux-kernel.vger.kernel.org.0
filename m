Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14DF3218D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 15:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfEQNFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 09:05:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56100 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfEQNFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 09:05:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id x64so6877485wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vaB+OdjsG8viJ4FyS4fKjKvehzlQvH9QRLvZ75BY8fM=;
        b=ngUzaKdOzcX3F5VP0BKsw7S6V+5BHIUZgyNTSY96DAv/1dWWAhuDZ8cTQ5roo3+el1
         NWLRku1Z23kJIomw5VwsHCVcrFD3bSnMI8OeoWEGhwkeHs66GCsqe4cJMIN2jAwNDuJ2
         FdnA7iF89eTaXsqfkPEC6eSwzEoCNbogtKmA8lBw6Htl85z5HMJ/bxl9/RAzH4Hq7GY3
         MRBvFcHqLn4scXb5Z35MRQhWwFH816dC63EHKTS1iVxXfnBSqa6AMxZLxAKFRF79zzxz
         MpygDVR3XOd33jk0zPQkqQhB6fhXqKRzRA2A/dP5S+bd3Vdt27njNSXF0MT7w7zYHUas
         /VcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vaB+OdjsG8viJ4FyS4fKjKvehzlQvH9QRLvZ75BY8fM=;
        b=bEc7j9aMe5BkwJ6BCfyuvxrWWWSts5u6IqlO0tddzzQ8Fptb3LxnQnuW4i3irBBiTw
         0OMaBKBLT8HZA7fWw9u3kSFzPKCypGI7+01bvp5pGu9hgS4WPWD/sw8sblWh/m/vEcT6
         HunEhr6xR1YvvWLjc+WKpYk+8aaaruGt6iaP1LyNCie5a3nrZjzZRAP+XlPqdSVE67Vx
         EZ03A2n03j0vUISgHsfcaWjF1RwCCUGoM7wGk4Wedi9mwhj4qVdSVL1Lyp0b2OvOemoF
         mn5+n2kTXXu5OlA5bxI5J0SE6tfZe0F5UTJ0a/Lu0Qma8VMIKjx5Bn54fVBd1LvVqz/g
         gbmg==
X-Gm-Message-State: APjAAAWklmlbUhFjfeZ/KCBXrmkGDmmllYCZfWV0sb6ypmOr1XFfFEHe
        eBcauKrLR3eLHa1l+Rk9/gU=
X-Google-Smtp-Source: APXvYqzq2fpINvtEJgqLPDhUzc8bGd34ybF1vEVlVOW37a9S6fbFE+jNnbwvTSj+E3cColdHRLIgMQ==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr2108595wmc.124.1558098312338;
        Fri, 17 May 2019 06:05:12 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g13sm3200039wrw.63.2019.05.17.06.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 06:05:11 -0700 (PDT)
Date:   Fri, 17 May 2019 15:05:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     yabinc@google.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/4] perf/ring_buffer: Fix exposing a temporarily
 decreased data_head.
Message-ID: <20190517130509.GA90824@gmail.com>
References: <20190517115230.437269790@infradead.org>
 <20190517115418.224478157@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517115418.224478157@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> In perf_output_put_handle(), an IRQ/NMI can happen in below location and
> write records to the same ring buffer:
> 	...
> 	local_dec_and_test(&rb->nest)
> 	...                          <-- an IRQ/NMI can happen here
> 	rb->user_page->data_head = head;
> 	...
> 
> In this case, a value A is written to data_head in the IRQ, then a value
> B is written to data_head after the IRQ. And A > B. As a result,
> data_head is temporarily decreased from A to B. And a reader may see
> data_head < data_tail if it read the buffer frequently enough, which
> creates unexpected behaviors.
> 
> This can be fixed by moving dec(&rb->nest) to after updating data_head,
> which prevents the IRQ/NMI above from updating data_head.
> 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Fixes: ef60777c9abd ("perf: Optimize the perf_output() path by removing IRQ-disables")
> Signed-off-by: Yabin Cui <yabinc@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20190516184010.167903-1-yabinc@google.com

So these are missing a bunch of:

  From: Yabin Cui <yabinc@google.com>

lines, right?

Thanks,

	Ingo
