Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA08177234
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 10:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgCCJSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 04:18:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41074 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgCCJSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:18:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id v4so3345753wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 01:18:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pXW4XibhqAWbXclYMHPjPrIsQTzUNXr/pk+A3VeMp8Q=;
        b=eLx1Veu4TkTqn3FZK+z7f5yUsK+KpqWmcfmONDrJj8SeU2/np9HBU7p1rnHKCBxZi1
         7URsTPDw96yburlPWCAGn9c0AUlJ1QwoVeE/0udwwgpL9eAuWhHFhGiCX/NwTCL9blGO
         /cv7r/xwQlnBZZ5J6H8zmAWb2Afl8+dm/9v/GxCyHTbeDKTsVARvxOjDa2eEfY3fBHIK
         ffXFMpy/LBmEFjv4w8wV50yjxPCRYOqlEb8q+dYJvGh4QEagHszqQfrGJY1AotaK8Anb
         cYf3xWJTkfy1JGhr6976RMAhtcjBYEufej5/fp+u4YzGim71k8WbyaM+8KbE1fV4kxPe
         M84g==
X-Gm-Message-State: ANhLgQ26Nc1KyZ2464CnxrPStaHWNlCXx40urU/GESS1OEwCBpW4MkoB
        pnAtZOCkRDw17e6WtX4/uh8=
X-Google-Smtp-Source: ADFU+vuBgMiydd/l2UUSufgoAbaYi+wHaw+zSqFwkxZNbX4n0pu0OFPRgcX7TTqLwk7xAerOFo/hKQ==
X-Received: by 2002:adf:d086:: with SMTP id y6mr4333948wrh.387.1583227117589;
        Tue, 03 Mar 2020 01:18:37 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id z5sm2847585wml.48.2020.03.03.01.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 01:18:36 -0800 (PST)
Date:   Tue, 3 Mar 2020 10:18:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>, pv-drivers@vmware.com,
        Dan Williams <dan.j.williams@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-graphics-maintainer@vmware.com,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 0/9] Huge page-table entries for TTM
Message-ID: <20200303091836.GC4380@dhcp22.suse.cz>
References: <20200220122719.4302-1-thomas_os@shipmail.org>
 <cc469a2a-e31c-4645-503a-f225fb101899@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc469a2a-e31c-4645-503a-f225fb101899@shipmail.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28-02-20 14:08:04, Thomas Hellström (VMware) wrote:
> Andrew, Michal
> 
> I'm wondering what's the best way here to get the patches touching mm
> reviewed and accepted?

I am sorry, but I am busy with other stuff and unlikely to find time to
review this series.
-- 
Michal Hocko
SUSE Labs
