Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0B92170DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 02:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgB0Bln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 20:41:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:57372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgB0Blm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 20:41:42 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED623208E4;
        Thu, 27 Feb 2020 01:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582767702;
        bh=zlU+Mz8nl1wZykQwoywF5NYDM925aYXitUfhUJEFdWU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pz5oD86KPZttD/NpbHpThtTRB2GMFbr5zWEIct45dfm69sKvsQiXBEx9SUMUmVrfK
         HK7HH28LBrhShehywrBdC5uLBkB06JNGMe91rnjwoVbz32CG2UZeHHONzPRIP2JRML
         1foQ4EmW6m7KPl2YBaC8/vzHStmyrtq6fW4bPgRY=
Date:   Wed, 26 Feb 2020 17:41:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v1 0/3] kcov: collect coverage from usb soft interrupts
Message-Id: <20200226174141.d1c938e7962a4fc09060eba9@linux-foundation.org>
In-Reply-To: <cover.1582742673.git.andreyknvl@google.com>
References: <cover.1582742673.git.andreyknvl@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 19:48:06 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:

> This patchset extends kcov to allow collecting coverage from soft
> interrupts and then uses the new functionality to collect coverage from
> USB code.
> 
> This has allowed to find at least one new HID bug [1], which was recently
> fixed by Alan [2].

I might have asked this before, but I don't see this obvious question
addressed in the changelogs so maybe I didn't...

Will this only ever be useful for USB?  Or is it anticipated that other
subsystems will use this?  If the latter, which ones?

Thanks.
