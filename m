Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 971CEBE017
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 16:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437491AbfIYOcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 10:32:13 -0400
Received: from foss.arm.com ([217.140.110.172]:50982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437142AbfIYOcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:32:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C507728;
        Wed, 25 Sep 2019 07:32:12 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FB9E3F59C;
        Wed, 25 Sep 2019 07:32:12 -0700 (PDT)
Date:   Wed, 25 Sep 2019 15:32:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kmemleak: DEBUG_KMEMLEAK_EARLY_LOG_SIZE changed
 names
Message-ID: <20190925143209.GE7042@arrakis.emea.arm.com>
References: <20190925143114.19698-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925143114.19698-1-jcline@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 02:31:14PM +0000, Jeremy Cline wrote:
> Commit c5665868183f ("mm: kmemleak: use the memory pool for early
> allocations") renamed CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE to
> CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE. Update the documentation reference
> to reflect that.
> 
> Signed-off-by: Jeremy Cline <jcline@redhat.com>

I forgot about this. Thanks.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
