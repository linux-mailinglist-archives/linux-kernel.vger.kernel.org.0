Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6829CCD20
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 00:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfJEWin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 18:38:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44389 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJEWin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 18:38:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id u22so9223735qkk.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 15:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=fHN77US4+VYq3DlO+1Rmg/MJTyEQKAjNoh7mf3T2cr8=;
        b=rH94qsZQ1zUlNvtB46B4Q/FapNdweQcvPLUIUVKG6PieN2mezMQyrlzf5a/xSCXTwm
         fuW+IzkO0srB5ezJHaBce8IpOf0tZbbhCE1ow+09DD6Emqt4R3D4F0m7Xx3ZkmGjktGE
         JBekY0SCekOGe+IVa6bLLxbOcHYarUsjHpwil+EIF8pCPazDT+QjP/9EJ9O3mvgZMnbY
         dpkNql9D/09g3+oozWMzGg26DOLVxrb+qnablc1YbP+MWmo4UHVcvO2EIMOXYOqWhxN9
         HLj35qQ+AswkImVEfC5Hjmc8KevHEK5ZATy+6Xt0eIwH3qa0ChqmgYxD4HxtwqWZl/Km
         X+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=fHN77US4+VYq3DlO+1Rmg/MJTyEQKAjNoh7mf3T2cr8=;
        b=V/fPlZSGkWVdkMwOKx9S78dKwcM80AsAzG/WSuZgiVGHfhp7V66/YtyafZmW0VmDAZ
         q1KbNHYmur/fTFWEE95Hx6/0E6oiTN3gULP4+lv0+NHz5SVsg2kXU23jfW02iJLGzXZ6
         NjBdjsyrOFOG0y6QsDVV+i77hA8cHlspOgkzIIEpVtLfmPUIHpDpjwWh0Dyae0p2z+xW
         5DvjKc8kOKUnq8s52XG8xtqe4zfCtv6dbzT7WRiqgg9wNX0vu4vEM785lB0ahpNj4Jp2
         b/tn7jL0oh27Cyqfz1LwlrYKbtrTkA7qgFwI3y5FBwAKJbQldo/pwg09GGjj7+uwRwVw
         BEgg==
X-Gm-Message-State: APjAAAU+mZmRyMsg0cjiF/mVtge6JNrVygv5cD5izalNxs7umY+T/lAZ
        nHFf5i2gLk7Asbgga7eW7LTAFA==
X-Google-Smtp-Source: APXvYqzz2qz3pmvZKX5r7Jp8zE9/AhVJ0z3Kfw2ReOkZyC4Bw/NXIPhxwy5QRdt+d3Y8rxnbouSsLQ==
X-Received: by 2002:a37:a946:: with SMTP id s67mr17630319qke.470.1570315120427;
        Sat, 05 Oct 2019 15:38:40 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 199sm5505955qkk.112.2019.10.05.15.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2019 15:38:39 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in has_unmovable_pages()
Date:   Sat, 5 Oct 2019 18:38:38 -0400
Message-Id: <615D1FE9-C16A-4FD5-A113-1C50AB3F0222@lca.pw>
References: <20191005142232.e08976cf8905824fad0533ff@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191005142232.e08976cf8905824fad0533ff@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (17A860)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 5, 2019, at 5:22 PM, Andrew Morton <akpm@linux-foundation.org> wrot=
e:
>=20
> Apparently some console drivers can do memory allocation on the printk()
> path.
>=20
> This behavior is daft, IMO.  Have we identified which ones and looked
> into fixing them?

Not necessary that simple. It is more of 2+ CPUs required to trigger the dea=
dlock. Please see my v2 patch I sent which has all the information. Especial=
ly, the thread link included there which contains a few lockdep splat traces=
 and the s390 one in the patch description.=
