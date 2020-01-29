Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A46B14D25A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 22:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgA2VPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 16:15:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgA2VPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 16:15:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F07F20674;
        Wed, 29 Jan 2020 21:14:59 +0000 (UTC)
Date:   Wed, 29 Jan 2020 16:14:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 01/12] tracing: Add trace_array_find/_get() to find
 instance trace arrays
Message-ID: <20200129161458.2647379b@gandalf.local.home>
In-Reply-To: <cb68528c975eba95bee4561ac67dd1499423b2e5.1580323897.git.zanussi@kernel.org>
References: <cover.1580323897.git.zanussi@kernel.org>
        <cb68528c975eba95bee4561ac67dd1499423b2e5.1580323897.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 12:59:21 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

FYI, I prefer the "Signed-off-by" to come at the end.

I switched them all.

-- Steve
