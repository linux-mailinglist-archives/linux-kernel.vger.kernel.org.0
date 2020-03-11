Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A7A181AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 15:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgCKOTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 10:19:03 -0400
Received: from foss.arm.com ([217.140.110.172]:50288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729559AbgCKOTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:19:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4D7431B;
        Wed, 11 Mar 2020 07:19:02 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17CF53F67D;
        Wed, 11 Mar 2020 07:19:01 -0700 (PDT)
Date:   Wed, 11 Mar 2020 14:19:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/2] Revert "mm/kmemleak: annotate various data
 races obj->ptr"
Message-ID: <20200311141900.GH3216816@arrakis.emea.arm.com>
References: <1583263716-25150-1-git-send-email-cai@lca.pw>
 <1583263716-25150-2-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583263716-25150-2-git-send-email-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 02:28:36PM -0500, Qian Cai wrote:
> This reverts commit a03184297d546c6531cdd40878f1f50732d3bac9.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
