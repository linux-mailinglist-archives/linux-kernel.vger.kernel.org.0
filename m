Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3F943896
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733239AbfFMPG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:06:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732404AbfFMOGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:06:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02DF7307D986;
        Thu, 13 Jun 2019 14:06:49 +0000 (UTC)
Received: from treble (ovpn-121-232.rdu2.redhat.com [10.10.121.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67F4180E5;
        Thu, 13 Jun 2019 14:06:43 +0000 (UTC)
Date:   Thu, 13 Jun 2019 09:06:36 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: mmotm: objtool warning
Message-ID: <20190613140636.nokozwltmqrmyrin@treble>
References: <5baaf9ec-8ea7-544c-49d1-dde519d919ca@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5baaf9ec-8ea7-544c-49d1-dde519d919ca@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 13 Jun 2019 14:06:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 07:57:43PM -0700, Randy Dunlap wrote:
> In yesterday's mmotm, I see this objtool warning:
> 
> arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x908: unreachable instruction

I think it's this one again:

  https://lkml.kernel.org/r/15ed85f4-bf2e-da91-71c1-46875d1c6e3f@infradead.org

I still can't reproduce it, and I still don't understand it...

-- 
Josh
