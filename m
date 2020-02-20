Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52291165A23
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 10:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgBTJ12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 04:27:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgBTJ11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:27:27 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9EB820801;
        Thu, 20 Feb 2020 09:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582190847;
        bh=XgKAWIq9e6qAgZoVDhw9r2LNsJdmFShHckDTrw/YwQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0hINo/Z0z0lHhBBiiUKy1fk51vRDZ8cxOvOQ0UFCdwyy5Hd9E/z9sUBe2gYguR0s
         eZMkfFLEY84H4JrrB24U/XbanQSWUBvjHnLYKv4zxSawW+Zthkn4+fOANXlAYOv3XF
         LicQQ/pCuojfq6hcKl7i/bxGdFc90S6Ppl5jJDlk=
Date:   Thu, 20 Feb 2020 09:27:22 +0000
From:   Will Deacon <will@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <trivial@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: arm64: fix trivial spelling enought to enough in
 memory.rst
Message-ID: <20200220092721.GA12780@willie-the-truck>
References: <20200219221403.16740-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219221403.16740-1-scott.branden@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 02:14:03PM -0800, Scott Branden wrote:
> Fix trivial spelling error enought to enough in memory.rst.
> 
> Cc: trivial@kernel.org
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  Documentation/arm64/memory.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I can take this along with the other arm64 fixes I have pending.

Will
