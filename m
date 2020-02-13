Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D3915CECA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 00:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgBMXyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 18:54:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbgBMXyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 18:54:53 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 114AF217BA;
        Thu, 13 Feb 2020 23:54:52 +0000 (UTC)
Date:   Thu, 13 Feb 2020 18:54:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <tzanussi@gmail.com>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] tracing: synth_event_trace fixes
Message-ID: <20200213185451.1a05feea@oasis.local.home>
In-Reply-To: <1581636974.2374.2.camel@gmail.com>
References: <cover.1581630377.git.zanussi@kernel.org>
        <1581636974.2374.2.camel@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 17:36:14 -0600
Tom Zanussi <tzanussi@gmail.com> wrote:

> Hi Steve,
> 
> I apparently tested the wrong patches, and while I think patch 1 and 3
> are ok, I'm seeing a problem with patch 2 (then endian changes).  Will
> send a v2 as soon as I can.
> 

Due to other priorities, I haven't had a chance to look at theses yet.
So no hurry.

-- Steve

