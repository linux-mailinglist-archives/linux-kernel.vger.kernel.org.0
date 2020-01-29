Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A83AB14D253
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 22:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgA2VJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 16:09:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbgA2VJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 16:09:17 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 962E320674;
        Wed, 29 Jan 2020 21:09:16 +0000 (UTC)
Date:   Wed, 29 Jan 2020 16:09:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 07/12] tracing: Add synth_event_trace() and related
 functions
Message-ID: <20200129160915.4ebe0f08@gandalf.local.home>
In-Reply-To: <7a84de5f1854acf4144b57efe835ca645afa764f.1580323897.git.zanussi@kernel.org>
References: <cover.1580323897.git.zanussi@kernel.org>
        <7a84de5f1854acf4144b57efe835ca645afa764f.1580323897.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 12:59:27 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> +static struct synth_field *find_synth_field(struct synth_event *event,
> +					    const char *field_name)
> +{
> +	struct synth_field *field = NULL;
> +	unsigned int i;
> +
> +	for (i = 0; i < event->n_fields; i++) {
> +		field = event->fields[i];
> +		if (strcmp(field->name, field_name) == 0)
> +			return field;
> +	}
> +
> +	return NULL;
> +}

Why duplicate all theses functions and not use them in the
synth_event_trace() directly?

-- Steve
