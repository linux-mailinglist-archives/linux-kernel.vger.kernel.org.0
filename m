Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D08E12115
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 19:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfEBRe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 13:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfEBRe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 13:34:26 -0400
Received: from localhost (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C09C5205F4;
        Thu,  2 May 2019 17:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556818466;
        bh=k1Mng5fkxG2kqXsRSaQDBN/3qrjtIBnMdTR42nRFITQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hp6CAJKtym6IoN734hnJoB9bKolzpSd0R7qRYpUjsgNKYsINuqSetNrT1/y1xcNaN
         6xMHqCPis63NBoZhcvCRXmKfvQQYWd1l/DP9A5DA3xV1FqO6dXcr1bM8eS8DJT8DaH
         JFX5NmJuqQJsTHn1vYCIS0QS8K+KpZZYBJoG9Pjs=
Date:   Thu, 2 May 2019 13:34:19 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        akpm@linux-foundation.org, mhocko@suse.com,
        dave.hansen@linux.intel.com, dan.j.williams@intel.com,
        keith.busch@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, zwisler@kernel.org, thomas.lendacky@amd.com,
        ying.huang@intel.com, fengguang.wu@intel.com, bp@suse.de,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        jglisse@redhat.com, david@redhat.com
Subject: Re: [v4 2/2] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
Message-ID: <20190502173419.GA3048@sasha-vm>
References: <20190501191846.12634-1-pasha.tatashin@soleen.com>
 <20190501191846.12634-3-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190501191846.12634-3-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 03:18:46PM -0400, Pavel Tatashin wrote:
>It is now allowed to use persistent memory like a regular RAM, but
>currently there is no way to remove this memory until machine is
>rebooted.
>
>This work expands the functionality to also allows hotremoving
>previously hotplugged persistent memory, and recover the device for use
>for other purposes.
>
>To hotremove persistent memory, the management software must first
>offline all memory blocks of dax region, and than unbind it from
>device-dax/kmem driver. So, operations should look like this:
>
>echo offline > echo offline > /sys/devices/system/memory/memoryN/state

This looks wrong :)

--
Thanks,
Sasha
