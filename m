Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A40CC123A28
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 23:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfLQWnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 17:43:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfLQWnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:43:41 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5BFC21582;
        Tue, 17 Dec 2019 22:43:40 +0000 (UTC)
Date:   Tue, 17 Dec 2019 17:43:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: ftrace trace_raw_pipe format
Message-ID: <20191217174339.1b622706@gandalf.local.home>
In-Reply-To: <20191217173403.61f4e2d8@gandalf.local.home>
References: <e8f9744ddffc4527b222ce72d41c61a1@AcuMS.aculab.com>
        <20191217173403.61f4e2d8@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 17:34:03 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

>  $ gcc -g -Wall read-trace-pipe-raw.c -o read-trace-pipe-raw -ltraceevent -ldl

I plan on adding this to the top of the file:

  // SPDX-License-Identifier: LGPL-2.1

In case you are wondering what license it will be under.

-- Steve
