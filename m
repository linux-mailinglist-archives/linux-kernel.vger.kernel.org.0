Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F309B1068D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 10:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKVJ2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 04:28:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:42546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbfKVJ2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:28:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5628FB2DF;
        Fri, 22 Nov 2019 09:28:08 +0000 (UTC)
Date:   Fri, 22 Nov 2019 10:27:54 +0100
From:   Torsten Duwe <duwe@suse.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: KASAN_INLINE && patchable-function-entry
Message-ID: <20191122102754.5a007f66@blackhole>
In-Reply-To: <20191121183630.GA3668@lakrids.cambridge.arm.com>
References: <20191121183630.GA3668@lakrids.cambridge.arm.com>
Organization: Suse Linux GmbH
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark!

On Thu, 21 Nov 2019 18:36:32 +0000
Mark Rutland <mark.rutland@arm.com> wrote:
[...]
> Was it intended that -fpatachable-function-entry behaved differently
> from -pg in this regard?

No way! I tried to model it as closely as possible along the established
instrumentation mechanism(s).

> Is this likely to be problematic for other users?

I don't think "likely" is the right word here. "rare" would be even
worse. One corner case is more than enough.

> Are there other implicitly-generated functions we need to look out for
> here, for which this would be a problem?
> 
> It looks like this also applies to __attribute__((naked)) on ARM,

IMHO gcc should instrument neither implicitly-generated nor naked
functions in this way. Anybody with reasonable objections please speak
up now.

I'd call it a gcc bug; but it may take a few days...

	Torsten
