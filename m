Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E814F53A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 00:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgAaXdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 18:33:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgAaXdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 18:33:10 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25D6120663;
        Fri, 31 Jan 2020 23:33:09 +0000 (UTC)
Date:   Fri, 31 Jan 2020 18:33:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/4] tracing: Consolidate some synth_event_trace code
Message-ID: <20200131183307.4c23f5d3@gandalf.local.home>
In-Reply-To: <1580511632.5607.3.camel@kernel.org>
References: <cover.1580506712.git.zanussi@kernel.org>
        <d1c8d8ad124a653b7543afe801d38c199ca5c20e.1580506712.git.zanussi@kernel.org>
        <20200131174344.5606d154@gandalf.local.home>
        <1580511632.5607.3.camel@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 17:00:32 -0600
Tom Zanussi <zanussi@kernel.org> wrote:
> 
> Here's the patch with __synth_event_add_val() made static.  Let me know
> if you want me to just do a v2 of this series..
> 

No, I'll just pull this in over the other one and start testing it.

Thanks a lot for getting this done today!

-- Steve
