Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B06911B8FB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 17:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbfLKQhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 11:37:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729880AbfLKQhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:37:21 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 150E62073D;
        Wed, 11 Dec 2019 16:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576082240;
        bh=1g2Td3utqqHhZjL83xQD4Cf+Ww6NhdiupS21IpXpBGQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VCdj4GPu0Zu8W64dgZt/yWhxbfvDn+EEcFzr+tIbBuymMuPHe4G7LvQhYq4zi3qpA
         //MV/ecEHFnXgwT2LM6lN3nRty9IhkCkXrNR4gNzSGD81i/aecO4XC1LlsveLPVwrm
         /jpD6fw/JlHwz/tDlm5DJXZ1l41AuszWgQrTuzR8=
Message-ID: <1576082238.2833.8.camel@kernel.org>
Subject: Re: ftrace histogram sorting broken on BE architecures
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Sven Schnelle <svens@stackframe.org>
Cc:     linux-trace-devel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 11 Dec 2019 10:37:18 -0600
In-Reply-To: <20191211110959.2baeb70f@gandalf.local.home>
References: <20191211123316.GD12147@stackframe.org>
         <20191211103557.7bed6928@gandalf.local.home>
         <20191211110959.2baeb70f@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve, Sven,

On Wed, 2019-12-11 at 11:09 -0500, Steven Rostedt wrote:
> On Wed, 11 Dec 2019 10:35:57 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > Any thoughts on how to fix this? I'm not sure whether i fully
> > > understand the
> > > ftrace maps... ;-)  
> > 
> > Your analysis makes sense. I'll take a deeper look at it.
> 
> Sven,
> 
> Does this patch fix it for you?
> 
> Tom,
> 
> Correct me if I'm wrong, from what I can tell, all sums and keys are
> u64 unless they are a string. Thus, I believe this patch should not
> have any issues.

The sums are u64, but the keys may not be.  I'll take a look and see,
but I'm out today and won't be able to look into it until tomorrow, if
that's ok.

Tom

> 
> -- Steve
> 
> diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
> index 9a1c22310323..9e31bfc818ff 100644
> --- a/kernel/trace/tracing_map.c
> +++ b/kernel/trace/tracing_map.c
> @@ -148,8 +148,8 @@ static int tracing_map_cmp_atomic64(void *val_a,
> void *val_b)
>  #define DEFINE_TRACING_MAP_CMP_FN(type)				
> 	\
>  static int tracing_map_cmp_##type(void *val_a, void *val_b)		
> \
>  {									
> \
> -	type a = *(type *)val_a;					
> \
> -	type b = *(type *)val_b;					
> \
> +	type a = (type)(*(u64 *)val_a);				
> 	\
> +	type b = (type)(*(u64 *)val_b);				
> 	\
>  									
> \
>  	return (a > b) ? 1 : ((a < b) ? -1 : 0);			
> \
>  }
