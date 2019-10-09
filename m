Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523D4D121B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbfJIPJq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Oct 2019 11:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbfJIPJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:09:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DAEB20B7C;
        Wed,  9 Oct 2019 15:09:44 +0000 (UTC)
Date:   Wed, 9 Oct 2019 11:09:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] string.h: Mark 34 functions with __must_check
Message-ID: <20191009110943.7ff3a08a@gandalf.local.home>
In-Reply-To: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019 14:14:28 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 9 Oct 2019 13:53:59 +0200
> 
> Several functions return values with which useful data processing
> should be performed. These values must not be ignored then.
> Thus use the annotation “__must_check” in the shown function declarations.
> 
> Add also corresponding parameter names for adjusted functions.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>

I'm curious. How many warnings showed up when you applied this patch?

-- Steve
