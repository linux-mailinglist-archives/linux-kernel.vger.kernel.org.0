Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEE36D2A59
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 15:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387995AbfJJNGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 09:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387959AbfJJNGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:06:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DA0A206B6;
        Thu, 10 Oct 2019 13:06:36 +0000 (UTC)
Date:   Thu, 10 Oct 2019 09:06:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/4] ftrace: Add an option for tracing console
 latencies
Message-ID: <20191010090634.721d1a3b@gandalf.local.home>
In-Reply-To: <CAPQh3wO1zvwQf0zmb9_ro1spUo+CCxJFCgB2aQJWVW8KZoXQdA@mail.gmail.com>
References: <20191008220824.7911-1-viktor.rosendahl@gmail.com>
        <20191008220824.7911-5-viktor.rosendahl@gmail.com>
        <20191009141114.GC143258@google.com>
        <CAPQh3wP93yF4R4LOabmBf8zqTgM7ZVT=_eZRPwgq5WKEESjnyw@mail.gmail.com>
        <20191009140804.74d9ab1f@gandalf.local.home>
        <CAPQh3wO1zvwQf0zmb9_ro1spUo+CCxJFCgB2aQJWVW8KZoXQdA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 09:57:31 +0200
Viktor Rosendahl <viktor.rosendahl@gmail.com> wrote:

> Sounds good to me. I will try to adjust the patch accordingly within a few days.

OK,

Also, I may hold off on patch 3. I want to make sure that adding a new
directory to tools is OK, and see if there's not other things we can
add there.

-- Steve
