Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF8C311B5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 16:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbfLKP4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 10:56:50 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41918 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731954AbfLKP4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:56:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so17068828lfp.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 07:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6PtV7kQOM1fs/75JzECVBBE8PJ8+B8ZeI1o5Edfap2c=;
        b=DvI4fA5zD5ykc+F93pbbfLI6LLKMKikKcit2sq9xYSQuoDU/lKpljdt5C1dBpWlow1
         2VS5QmzVGh3LZ/8NbouOtG6R7+KfoItlSbD25+TSP+gP/Fd9hNRCjOnWkSU3bf/HCY+8
         ruNKw25vlsTh4eh5vdTwBGiCyZBp5D/hOfKbQcrOE25lM++oLXRHGctYv3kJvmdqLUmx
         qrWpI4YvsVSsx1UC2HS5kuSPdn1E+eHnfEnGihmzuPENwC8HuFwG3l6beWyTUnWRjc0N
         WFrS6cTlMlYIuFziVqpWE9ncO/N1DwfPw5yeBYdP5GtK9+BQrMcGBKC/GoGDXM/bpn+B
         6Myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6PtV7kQOM1fs/75JzECVBBE8PJ8+B8ZeI1o5Edfap2c=;
        b=f7AMDz/Rt5GkLG32eGxDjywm5cdaUUHDsdhCdo5JZGUAfn/karbc4He9dhdWG4JxnC
         JbwZTYlHTkweYvk7b31x2MQsW63yXiDtPWF/k8nAW+Uh9q2YoeFDECrtEA0eIjAvruU3
         a0clEDdcw2fVGX/JD9sWYvkyQdcvkzOTmHb6LCUuXDsp9YAohPUPhNAf9/AVRKU/I6IU
         HOtviC2uNYlx5tCvORMSKeW3cWNXA/DnChH6waaexsXeZVko/K1QBLQTK5a094zMkBzP
         1IMsuWPwvi3N9f0OOI680PHRmi+dKAVnl4wifidTJbGwl+ODb/WDuMJwhvJGILzqRZzu
         nBGA==
X-Gm-Message-State: APjAAAXqnBj2cPWljiIuQ1MOlCFI3iHFx5BXb+tIB0gH0GvKD0aJRJo1
        zoZLgSTXoEu4OsxPuO0oUs4TPZywkgk=
X-Google-Smtp-Source: APXvYqyCTQ9D8OEwKjVcU/TL5Sz/kKTkuJLt8p3brBJ+wSapFx+p7jIywRyUGvQEAIGDLPikFwgMWw==
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr2622190lfp.133.1576079805797;
        Wed, 11 Dec 2019 07:56:45 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 207sm1587045ljj.72.2019.12.11.07.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:56:45 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id A5866101218; Wed, 11 Dec 2019 18:56:45 +0300 (+03)
Date:   Wed, 11 Dec 2019 18:56:45 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: Re: [RFC PATCH v1 4/4] mm/gup: flag to limit follow_page() to
 transhuge pages
Message-ID: <20191211155645.pkxphc4uo7ir6pbb@box>
References: <DB7PR02MB3979ECF6271070E49D062EAFBB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR02MB3979ECF6271070E49D062EAFBB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 09:29:19AM +0000, Mircea CIRJALIU - MELIU wrote:
> Sometimes the user needs to look up a transhuge page mapped at a given address.

There is no such examples in the current kernel, right?

-- 
 Kirill A. Shutemov
