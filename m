Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8F81988E6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 02:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgCaA1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 20:27:52 -0400
Received: from mx.sdf.org ([205.166.94.20]:50593 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729509AbgCaA1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:27:52 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02V0Rcil008616
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Tue, 31 Mar 2020 00:27:39 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02V0RcpH025667;
        Tue, 31 Mar 2020 00:27:38 GMT
Date:   Tue, 31 Mar 2020 00:27:38 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, lkml@sdf.org
Subject: Re: [RFC PATCH v1 44/50] arm64: ptr auth: Use get_random_u64 instead
 of _bytes
Message-ID: <20200331002738.GE9199@SDF.ORG>
References: <202003281643.02SGhOi3016886@sdf.org>
 <20200330105745.GA1309@C02TD0UTHF1T.local>
 <20200330193237.GC9199@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330193237.GC9199@SDF.ORG>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 07:32:37PM +0000, George Spelvin wrote:
> On Mon, Mar 30, 2020 at 11:57:45AM +0100, Mark Rutland wrote:
>> As I am unaware, how does the cost of get_random_bytes() compare to the
>> cost of get_random_u64()?
> 
> It's approximately 8 times the cost.

Just a expand on on a point I may have left unclear: One 
get_random_bytes(), for a length up to 32 bytes, is approximately
8x the one get_random_u64().  (Then it jumps to 16x for up
to 96 bytes.)

Since were're using *two* get_random_u64() calls to replace one
get_random_bytes(), it's a 4x cost difference between the two
alternative ways of generating a 128-bit key.
