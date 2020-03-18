Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41012189936
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 11:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgCRKYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 06:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgCRKYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:24:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3621E20775;
        Wed, 18 Mar 2020 10:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584527043;
        bh=SzEGn5r1AGDgVt7vbeRXmKq6T+/q5L8nfcLIKkGO7Ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v2JIq2Q21bNaR6uAYVtcb/dVQhma/0fAA66X6QFlF2BtiEH7OAeEE8tmFfoX8lL5c
         hO4sOwe3j4whcWxJA9IDJJ1kc32TnlTfyP5BfopDdAddAd2/06Dd3R4N/WRYiai+jU
         xu1tCs+OkMjOeBl1EsCNH9rkUBuZy7UdZxYrYmVk=
Date:   Wed, 18 Mar 2020 11:24:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>
Subject: Re: [PATCH 4/5] mm/vma: Replace all remaining open encodings with
 vma_set_anonymous()
Message-ID: <20200318102401.GA2126918@kroah.com>
References: <1581915833-21984-1-git-send-email-anshuman.khandual@arm.com>
 <1581915833-21984-5-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581915833-21984-5-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:33:52AM +0530, Anshuman Khandual wrote:
> This replaces all remaining open encodings with vma_set_anonymous().
> 
> Cc: Sudeep Dutt <sudeep.dutt@intel.com>
> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Richard Fontana <rfontana@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/misc/mic/scif/scif_mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The subject line does not match up with the file being modified here :(

