Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB9791366E6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 06:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgAJFqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 00:46:02 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:48512 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgAJFqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 00:46:02 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id A6B3C2009B2;
        Fri, 10 Jan 2020 05:46:00 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id F25982036B; Fri, 10 Jan 2020 06:45:51 +0100 (CET)
Date:   Fri, 10 Jan 2020 06:45:51 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     mark.rutland@arm.com, hch@infradead.org, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, xiexiuqi@huawei.com,
        yangyingliang@huawei.com, guohanjun@huawei.com, wcohen@redhat.com,
        linux-kernel@vger.kernel.org, mtk.manpages@gmail.com,
        wezhang@redhat.com
Subject: Re: [PATCH v2] sys_personality: Add a optional arch hook
 arch_check_personality() for common sys_personality()
Message-ID: <20200110054551.GA352443@light.dominikbrodowski.net>
References: <20200109133634.176483-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109133634.176483-1-bobo.shaobowang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 09:36:34PM +0800, Wang ShaoBo wrote:
> currently arm64 use __arm64_sys_arm64_personality() as its default
> syscall. But using a normal hook arch_check_personality() can reject
> personality settings for special case of different archs.
> 
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>

Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
