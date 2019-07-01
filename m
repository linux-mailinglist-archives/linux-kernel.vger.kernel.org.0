Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE0259D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 15:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfF1Nmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 09:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfF1Nmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:42:45 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 514EA20645;
        Fri, 28 Jun 2019 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561729363;
        bh=5ceO/Tq9Tf+56g0egKcMO4r+dlVrsAfjE5f1N+iaWgs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xSyOER+fZRqnkwog9N0L4fx10nJ3MBs/mnrObwO4PsZMHOmc3lOXOxcTQ/3/Z/t/v
         HGCwswD1LRdHC7+50GhN8UBL5pnthRRJnEOkya05tI64VthyBAKRLq1SCJ9OYEs2bn
         4fEsKi+w9LMCvJpMIn3TrdOjnExjuWfvxwxH4agw=
Message-ID: <1561729362.9333.8.camel@kernel.org>
Subject: Re: [PATCH 1/4] tracing: Simplify assignment parsing for hist
 triggers
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 08:42:42 -0500
In-Reply-To: <20190628143940.23b8f53f0ef754e9c6a5b947@kernel.org>
References: <cover.1561647046.git.zanussi@kernel.org>
         <17ac912dcec67c85e371b47dd2f55ae7c082b5f6.1561647046.git.zanussi@kernel.org>
         <20190628143940.23b8f53f0ef754e9c6a5b947@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Fri, 2019-06-28 at 14:39 +0900, Masami Hiramatsu wrote:
> On Thu, 27 Jun 2019 10:35:16 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > In the process of adding better error messages for sorting, I
> > realized
> > that strsep was being used incorrectly and some of the error paths
> > I
> > was expecting to be hit weren't and just fell through to the common
> > invalid key error case.
> 
> Would you mean this includes a bugfix too?
> 

Yes, though not actually a problem or visible to the user.  This
basically cleans things up so that the next patch adding the error
messages works as expected.

Tom

> > 
> > It also became obvious that for keyword assignments, it wasn't
> > necessary to save the full assignment and reparse it later, and
> > having
> > a common empty-assignment check would also make more sense in terms
> > of
> > error processing.
> > 
> > Change the code to fix these problems and simplify it for new error
> > message changes in a subsequent patch.
> > 
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> 
> Anyway looks good to me.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thanks,
> 
> > ---
> >  kernel/trace/trace_events_hist.c | 70 ++++++++++++++++----------
> > --------------
> >  1 file changed, 27 insertions(+), 43 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_hist.c
> > b/kernel/trace/trace_events_hist.c
> > index ca6b0dff60c5..964d032f51c6 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -1985,12 +1985,6 @@ static int parse_map_size(char *str)
> >  	unsigned long size, map_bits;
> >  	int ret;
> >  
> > -	strsep(&str, "=");
> > -	if (!str) {
> > -		ret = -EINVAL;
> > -		goto out;
> > -	}
> > -
> >  	ret = kstrtoul(str, 0, &size);
> >  	if (ret)
> >  		goto out;
> > @@ -2050,25 +2044,25 @@ static int parse_action(char *str, struct
> > hist_trigger_attrs *attrs)
> >  static int parse_assignment(struct trace_array *tr,
> >  			    char *str, struct hist_trigger_attrs
> > *attrs)
> >  {
> > -	int ret = 0;
> > +	int len, ret = 0;
> >  
> > -	if ((str_has_prefix(str, "key=")) ||
> > -	    (str_has_prefix(str, "keys="))) {
> > -		attrs->keys_str = kstrdup(str, GFP_KERNEL);
> > +	if ((len = str_has_prefix(str, "key=")) ||
> > +	    (len = str_has_prefix(str, "keys="))) {
> > +		attrs->keys_str = kstrdup(str + len, GFP_KERNEL);
> >  		if (!attrs->keys_str) {
> >  			ret = -ENOMEM;
> >  			goto out;
> >  		}
> > -	} else if ((str_has_prefix(str, "val=")) ||
> > -		   (str_has_prefix(str, "vals=")) ||
> > -		   (str_has_prefix(str, "values="))) {
> > -		attrs->vals_str = kstrdup(str, GFP_KERNEL);
> > +	} else if ((len = str_has_prefix(str, "val=")) ||
> > +		   (len = str_has_prefix(str, "vals=")) ||
> > +		   (len = str_has_prefix(str, "values="))) {
> > +		attrs->vals_str = kstrdup(str + len, GFP_KERNEL);
> >  		if (!attrs->vals_str) {
> >  			ret = -ENOMEM;
> >  			goto out;
> >  		}
> > -	} else if (str_has_prefix(str, "sort=")) {
> > -		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
> > +	} else if ((len = str_has_prefix(str, "sort="))) {
> > +		attrs->sort_key_str = kstrdup(str + len,
> > GFP_KERNEL);
> >  		if (!attrs->sort_key_str) {
> >  			ret = -ENOMEM;
> >  			goto out;
> > @@ -2079,12 +2073,8 @@ static int parse_assignment(struct
> > trace_array *tr,
> >  			ret = -ENOMEM;
> >  			goto out;
> >  		}
> > -	} else if (str_has_prefix(str, "clock=")) {
> > -		strsep(&str, "=");
> > -		if (!str) {
> > -			ret = -EINVAL;
> > -			goto out;
> > -		}
> > +	} else if ((len = str_has_prefix(str, "clock="))) {
> > +		str += len;
> >  
> >  		str = strstrip(str);
> >  		attrs->clock = kstrdup(str, GFP_KERNEL);
> > @@ -2092,8 +2082,8 @@ static int parse_assignment(struct
> > trace_array *tr,
> >  			ret = -ENOMEM;
> >  			goto out;
> >  		}
> > -	} else if (str_has_prefix(str, "size=")) {
> > -		int map_bits = parse_map_size(str);
> > +	} else if ((len = str_has_prefix(str, "size="))) {
> > +		int map_bits = parse_map_size(str + len);
> >  
> >  		if (map_bits < 0) {
> >  			ret = map_bits;
> > @@ -2133,8 +2123,14 @@ parse_hist_trigger_attrs(struct trace_array
> > *tr, char *trigger_str)
> >  
> >  	while (trigger_str) {
> >  		char *str = strsep(&trigger_str, ":");
> > +		char *rhs;
> >  
> > -		if (strchr(str, '=')) {
> > +		rhs = strchr(str, '=');
> > +		if (rhs) {
> > +			if (!strlen(++rhs)) {
> > +				ret = -EINVAL;
> > +				goto free;
> > +			}
> >  			ret = parse_assignment(tr, str, attrs);
> >  			if (ret)
> >  				goto free;
> > @@ -4459,10 +4455,6 @@ static int create_val_fields(struct
> > hist_trigger_data *hist_data,
> >  	if (!fields_str)
> >  		goto out;
> >  
> > -	strsep(&fields_str, "=");
> > -	if (!fields_str)
> > -		goto out;
> > -
> >  	for (i = 0, j = 1; i < TRACING_MAP_VALS_MAX &&
> >  		     j < TRACING_MAP_VALS_MAX; i++) {
> >  		field_str = strsep(&fields_str, ",");
> > @@ -4557,10 +4549,6 @@ static int create_key_fields(struct
> > hist_trigger_data *hist_data,
> >  	if (!fields_str)
> >  		goto out;
> >  
> > -	strsep(&fields_str, "=");
> > -	if (!fields_str)
> > -		goto out;
> > -
> >  	for (i = n_vals; i < n_vals + TRACING_MAP_KEYS_MAX; i++) {
> >  		field_str = strsep(&fields_str, ",");
> >  		if (!field_str)
> > @@ -4718,12 +4706,6 @@ static int create_sort_keys(struct
> > hist_trigger_data *hist_data)
> >  	if (!fields_str)
> >  		goto out;
> >  
> > -	strsep(&fields_str, "=");
> > -	if (!fields_str) {
> > -		ret = -EINVAL;
> > -		goto out;
> > -	}
> > -
> >  	for (i = 0; i < TRACING_MAP_SORT_KEYS_MAX; i++) {
> >  		struct hist_field *hist_field;
> >  		char *field_str, *field_name;
> > @@ -4732,9 +4714,11 @@ static int create_sort_keys(struct
> > hist_trigger_data *hist_data)
> >  		sort_key = &hist_data->sort_keys[i];
> >  
> >  		field_str = strsep(&fields_str, ",");
> > -		if (!field_str) {
> > -			if (i == 0)
> > -				ret = -EINVAL;
> > +		if (!field_str)
> > +			break;
> > +
> > +		if (!*field_str) {
> > +			ret = -EINVAL;
> >  			break;
> >  		}
> >  
> > @@ -4744,7 +4728,7 @@ static int create_sort_keys(struct
> > hist_trigger_data *hist_data)
> >  		}
> >  
> >  		field_name = strsep(&field_str, ".");
> > -		if (!field_name) {
> > +		if (!field_name || !*field_name) {
> >  			ret = -EINVAL;
> >  			break;
> >  		}
> > -- 
> > 2.14.1
> > 
> 
> 
