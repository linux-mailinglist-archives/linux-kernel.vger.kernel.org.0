Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7F4140303
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 05:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgAQE0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 23:26:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgAQE0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 23:26:18 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D14620748;
        Fri, 17 Jan 2020 04:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579235177;
        bh=sNetLEyfDPRRuML0NIpfa9qER9/y0UxaFx7na4fO55o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rMEx8bsc/4AtbauemogLDvALm4D8Ac1B3FedkSrrOA8fykacy/zzBXR2Xwy10vQwQ
         G/oOovc/lwHGyM5ET08+DGwOeow7T0qyj5fkpYzZIF1fd/GW5TOmRXKH3yD4GWVDJ6
         Qt7IauzcUTw2QtSEUdWfVf1loVWNSPRl6z3dAVbI=
Message-ID: <1579235176.2474.5.camel@kernel.org>
Subject: Re: Unresolved reference for histogram variable
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 16 Jan 2020 22:26:16 -0600
In-Reply-To: <20200116165658.4e8d15fb@gandalf.local.home>
References: <20200116154216.58ca08eb@gandalf.local.home>
         <20200116165658.4e8d15fb@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, 2020-01-16 at 16:56 -0500, Steven Rostedt wrote:
> On Thu, 16 Jan 2020 15:42:16 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > in parse_expr():
> > 
> > 	operand1->read_once = true;
> > 	operand2->read_once = true;
> > 
> > Why is that?
> > 
> > This means that any variable used in an expression can not be use
> > later
> > on.
> > 
> > Or should the variable be detected that it is used multiple times
> > in
> > the expression, and have the parser detect this, and just reuse the
> > same variable multiple times?
> 
> This patch seems to fix the problem, and lets us reuse the same
> variable multiple times.

It works for me too, and seems like it should be a good fix for the
problem.  The size and is_signed might be the overkill you're referring
to, but I'd like to spend time tomorrow verifying that and doing some
testing to make sure.

Thanks,

Tom

> 
> -- Steve
> 
> diff --git a/kernel/trace/trace_events_hist.c
> b/kernel/trace/trace_events_hist.c
> index 117a1202a6b9..b7f944735a4a 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -116,6 +116,7 @@ struct hist_field {
>  	struct ftrace_event_field	*field;
>  	unsigned long			flags;
>  	hist_field_fn_t			fn;
> +	unsigned int			ref;
>  	unsigned int			size;
>  	unsigned int			offset;
>  	unsigned int                    is_signed;
> @@ -2432,8 +2433,16 @@ static int contains_operator(char *str)
>  	return field_op;
>  }
>  
> +static void get_hist_field(struct hist_field *hist_field)
> +{
> +	hist_field->ref++;
> +}
> +
>  static void __destroy_hist_field(struct hist_field *hist_field)
>  {
> +	if (--hist_field->ref > 1)
> +		return;
> +
>  	kfree(hist_field->var.name);
>  	kfree(hist_field->name);
>  	kfree(hist_field->type);
> @@ -2475,6 +2484,8 @@ static struct hist_field
> *create_hist_field(struct hist_trigger_data *hist_data,
>  	if (!hist_field)
>  		return NULL;
>  
> +	hist_field->ref = 1;
> +
>  	hist_field->hist_data = hist_data;
>  
>  	if (flags & HIST_FIELD_FL_EXPR || flags &
> HIST_FIELD_FL_ALIAS)
> @@ -2670,6 +2681,19 @@ static struct hist_field
> *create_var_ref(struct hist_trigger_data *hist_data,
>  {
>  	unsigned long flags = HIST_FIELD_FL_VAR_REF;
>  	struct hist_field *ref_field;
> +	int i;
> +
> +	for (i = 0; i < hist_data->n_var_refs; i++) {
> +		ref_field = hist_data->var_refs[i];
> +		/* Maybe this is overkill? */
> +		if (ref_field->var.idx == var_field->var.idx &&
> +		    ref_field->var.hist_data == var_field->hist_data 
> &&
> +		    ref_field->size == var_field->size &&
> +		    ref_field->is_signed == var_field->is_signed) {
> +			get_hist_field(ref_field);
> +			return ref_field;
> +		}
> +	}
>  
>  	ref_field = create_hist_field(var_field->hist_data, NULL,
> flags, NULL);
>  	if (ref_field) {
