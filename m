Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E1218B123
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 11:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCSKVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 06:21:03 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:50574 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgCSKVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:21:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 271AB3F3BA;
        Thu, 19 Mar 2020 11:21:00 +0100 (CET)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=YIlRraCY;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 85z82hMh4gjk; Thu, 19 Mar 2020 11:20:59 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 6CE8C3F4F6;
        Thu, 19 Mar 2020 11:20:45 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 768023600BE;
        Thu, 19 Mar 2020 11:20:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1584613245; bh=V8lBBeyRDZgxGjvBgP3FyGRuA/pE02GkqJZ35o9y2dQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YIlRraCYki7VHR34mew970Lxo2NLkIGwy7IuqNkOsIvvNBDQjSyCc7KiXuL05mY8Q
         39Oazf0Pl2vXiL6ZgJquzyoxrCWEy8PfMxPefNiYV8PtCZE7Fz8i3MFTr1s2CTV0Hl
         Hmp8dbYShbrpUn5FTIcJx0y9D5GuWaYFNuneBK9s=
Subject: Re: Ack to merge through DRM? WAS [PATCH v6 0/9] Huge page-table
 entries for TTM
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, pv-drivers@vmware.com,
        Dan Williams <dan.j.williams@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-graphics-maintainer@vmware.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200304102840.2801-1-thomas_os@shipmail.org>
 <9eb1acd3-cded-65f0-ed75-10173dc3a41c@shipmail.org>
 <20200318162721.9b8a4d0ef7036ad93261f859@linux-foundation.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <5054bb71-b5b4-11a9-1c4e-487a7adf3177@shipmail.org>
Date:   Thu, 19 Mar 2020 11:20:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200318162721.9b8a4d0ef7036ad93261f859@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/20 12:27 AM, Andrew Morton wrote:
> On Mon, 16 Mar 2020 13:32:08 +0100 Thomas Hellström (VMware) <thomas_os@shipmail.org> wrote:
>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> Andrew, would it be possible to have an ack for merge using a DRM tree
>> for the -mm patches?
> Yes, please do.  It's all pretty straightforward addition of new
> functionality which won't affect existing code.

Thanks Andrew. Can I add your Acked-by: To the mm patches for Linus' 
reference?

Thanks,

Thomas


