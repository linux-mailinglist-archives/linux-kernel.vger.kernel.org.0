Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82BD912F4B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 15:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfECNeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 09:34:11 -0400
Received: from ozlabs.org ([203.11.71.1]:58671 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfECNeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:34:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44wY4w4qpzz9sBb;
        Fri,  3 May 2019 23:34:08 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Joe Perches <joe@perches.com>,
        Michael Ellerman <patch-notifications@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/powernv/ioda2: Add __printf format/argument verification
In-Reply-To: <cf6948fb8ab8e395e139a3440f3600a6050c1efa.camel@perches.com>
References: <44wNKc0KZFz9sPd@ozlabs.org> <cf6948fb8ab8e395e139a3440f3600a6050c1efa.camel@perches.com>
Date:   Fri, 03 May 2019 23:33:57 +1000
Message-ID: <87bm0jy856.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> writes:
> On Fri, 2019-05-03 at 16:59 +1000, Michael Ellerman wrote:
>> On Thu, 2017-03-30 at 10:19:25 UTC, Joe Perches wrote:
>> > Fix fallout too.
>> > 
>> > Signed-off-by: Joe Perches <joe@perches.com>
>> 
>> Applied to powerpc next, thanks.
>> 
>> https://git.kernel.org/powerpc/c/1e496391a8452101308a23b7395cdd49
>
> 2+ years later.

I was hoping for a new record.

cheers
