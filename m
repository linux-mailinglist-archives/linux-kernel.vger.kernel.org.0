Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 781D3133FFA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 12:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgAHLMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 06:12:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:42046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgAHLMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:12:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2E56EAC9A;
        Wed,  8 Jan 2020 11:12:00 +0000 (UTC)
Date:   Wed, 8 Jan 2020 12:11:58 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Sourabh Jain <sourabhjain@linux.ibm.com>
Cc:     mpe@ellerman.id.au, corbet@lwn.net, mahesh@linux.vnet.ibm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, gregkh@linuxfoundation.org,
        hbathini@linux.ibm.com
Subject: Re: [PATCH v6 3/6] powerpc/fadump: reorganize /sys/kernel/fadump_*
 sysfs files
Message-ID: <20200108111158.GY4113@kitsune.suse.cz>
References: <20191211160910.21656-1-sourabhjain@linux.ibm.com>
 <20191211160910.21656-4-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211160910.21656-4-sourabhjain@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 09:39:07PM +0530, Sourabh Jain wrote:
> As the number of FADump sysfs files increases it is hard to manage all of
> them inside /sys/kernel directory. It's better to have all the FADump
> related sysfs files in a dedicated directory /sys/kernel/fadump. But in
> order to maintain backward compatibility a symlink has been added for every
> sysfs that has moved to new location.

Patched this series into my test kernel and the sysfs sfiles look OK.

Tested-by: Michal Suchanek <msuchanek@suse.de>

Thanks

Michal
