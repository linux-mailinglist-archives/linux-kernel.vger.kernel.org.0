Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B323413B3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 21:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgANUfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 15:35:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgANUfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 15:35:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF17724655;
        Tue, 14 Jan 2020 20:34:58 +0000 (UTC)
Date:   Tue, 14 Jan 2020 15:34:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] bisected to: block: fix splitting segments on boundary
 masks
Message-ID: <20200114153456.2cbae42f@gandalf.local.home>
In-Reply-To: <e8bd9824-20ff-03e0-c289-e77c4f6669af@kernel.dk>
References: <20200113221317.0e27f0a9@rorschach.local.home>
        <e8bd9824-20ff-03e0-c289-e77c4f6669af@kernel.dk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020 21:09:41 -0700
Jens Axboe <axboe@kernel.dk> wrote:

> Can you try:
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.5&id=1ca6b68e516b3de3707ae2cec9e206c8f9dd816e

This appears to fix the situation, Thanks!

Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
