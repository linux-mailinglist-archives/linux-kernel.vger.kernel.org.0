Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B7E109DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 13:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfKZMTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 07:19:04 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:52792 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbfKZMTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:19:04 -0500
Received: by mail-wm1-f46.google.com with SMTP id l1so2980775wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 04:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7FMoRj/ytJrUR66B8EfiOg4Y0/kxvjsVOapeN7HOSP0=;
        b=p4To6L/uUB4Ynfx7xv9qYg7QuplT6BywCInGbTvO70p7KOEHOF7T4FECjv05a/l7EA
         pCjPMiBaFxR4pe+3hRAvs3KwYMZhkhq/NhVPTd5Nr/BVauiSiKH2m++0/jH65PvXmWOT
         ILSo5VBDmduw14z8IvMPXgw20oTeQV7NttmjsCsdylkKNSbrWersAkLvbVyRrQlsoDPB
         IXq0EymWCaphhE/9nrJ7OiBFEtp/a29Oks1li4Q/T63kuH6rYsjR/6+PIa1MIemoDBSG
         sLPUgG9OS2BNT+8di8HFdZALDyJathMBjtFV9ZKiHJtO9qiHdB4dDwi8JLFv0oeeFS1E
         H9VA==
X-Gm-Message-State: APjAAAUjDPPf+UVuByThSUzaIhharhuApPTBKF8NuxcCp3fHMoTYOlH6
        ArSDvEYtN1C7LA2Hs8kTfkOsC3zO
X-Google-Smtp-Source: APXvYqxrUOL9z2BdQOQxB0IBtlt/5B6vcbAXvaMuNfOtiZR8bhwJK4TpfNTavnKN5FLTbsYbr+2Wuw==
X-Received: by 2002:a7b:c006:: with SMTP id c6mr4186483wmb.52.1574770742789;
        Tue, 26 Nov 2019 04:19:02 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id k18sm14941263wrm.82.2019.11.26.04.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 04:19:02 -0800 (PST)
Date:   Tue, 26 Nov 2019 13:19:01 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Cristopher Lameter <cl@linux.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: SLUB: purpose of sysfs events on cache creation/removal
Message-ID: <20191126121901.GE20912@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have just learnt about KOBJ_{ADD,REMOVE} sysfs events triggered on
kmem cache creation/removal when SLUB is configured. This functionality
goes all the way down to initial SLUB merge. I do not see any references
in the Documentation explaining what those events are used for and
whether there are any real users.

Could you shed some more light into this?
-- 
Michal Hocko
SUSE Labs
