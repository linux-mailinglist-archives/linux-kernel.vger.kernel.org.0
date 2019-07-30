Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 314C779D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 02:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfG3Avm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 20:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbfG3Avl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 20:51:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20A0820651;
        Tue, 30 Jul 2019 00:51:40 +0000 (UTC)
Date:   Mon, 29 Jul 2019 20:51:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: Re: [PATCH 7/7] tracing: Un-export ftrace_set_clr_event
Message-ID: <20190729205138.689864d2@gandalf.local.home>
In-Reply-To: <1564444954-28685-8-git-send-email-divya.indi@oracle.com>
References: <1564444954-28685-1-git-send-email-divya.indi@oracle.com>
        <1564444954-28685-8-git-send-email-divya.indi@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019 17:02:34 -0700
Divya Indi <divya.indi@oracle.com> wrote:

> Use "trace_array_set_clr_event" to enable/disable events to a trace
> array from other kernel modules/components.
> Hence, we no longer need to have ftrace_set_clr_event as an exported API.

Hmm, this simply reverts patch 1. Why have patch 1 and this patch in
the first place?

-- Steve

> 
> Signed-off-by: Divya Indi <divya.indi@oracle.com>
> Reviewed-By: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
