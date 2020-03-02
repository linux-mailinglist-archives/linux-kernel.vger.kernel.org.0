Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 447C2175E2D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 16:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgCBP3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 10:29:14 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52429 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgCBP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:29:14 -0500
Received: by mail-pj1-f65.google.com with SMTP id lt1so1856586pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 07:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZELvoTh0xXCJ16TM4LMcgSPymnk+qgV/Io9vwrxStOI=;
        b=Ka8fcbUomoExO8dMtRavZ6xdQDFoqTL+dMYjjXJnplJQqNty6kInHp/SA8oQqkNfoc
         mGep+DT/B7MFOUmHtYk3Eyuppv9vkrOcmRjAuJUUYww44Ms+jsBHeJpww+mCDbHSZAAo
         RBzbstkJYS1XpxL0UmA1+0+jaBFLusmx5PUpRtILwXTlfTbNUuTesemYQ7OGCVxovv3j
         DF0Aed3Nhf2ftEM8pWNsvWYJC8mmM6oEG2lFzB7anqXDcc8Z8x/65c9/4D2oV9vGlHyq
         ry9YkJu6JP4Kr19aM9RJmNgMs/42jsFIay1p87AEAgxzNxMwLhQXcz+W8wNEcv4h32Rx
         rgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZELvoTh0xXCJ16TM4LMcgSPymnk+qgV/Io9vwrxStOI=;
        b=BzsMXAbUG28ehaSp6QRdIkY4RwlLrmXTCoJz2tkyAGFeQ7YXjRd4I1us9O3FCNHDDG
         t/E6ld4RcUssgSPLnXel8ITabyUJn25QdjrmWPZPDVGD4eR5z8rwdfCLcO+3yexndlpG
         iUI8PZ7/3OXrNcDbp01ngjiX2663SAR3Fz7GRBh3tJXXWAjVV8PI6ip+iPlSErWXNIkU
         x0xt/AYZ8Hb58sTyf6mAa7ifX1Ih7Hr0QhOmsHxQtdReDTBvp0HxBiA9m3w0muOL30kh
         edcC/qOFvYabY4GLqB/F0IcFqqn4o1iiMjCgl7cRryWxOvEp1LT4Dezm9zBsqTjbDE7y
         Gd8Q==
X-Gm-Message-State: APjAAAVVuHdHibrQ/2++2QjP+GMutdA4sOU0zm6ypbQjyYZYwXQJycqY
        uenlFtPRnj41Um/ZxOZh5AGEMg==
X-Google-Smtp-Source: APXvYqyxlU/eQXwoIsbmUvLYYQ4AbS80Gp7//bZAGJ2KIFGK4BxXwB+sNYYCGL1sq8Z5F8aZXJNFig==
X-Received: by 2002:a17:902:b40c:: with SMTP id x12mr18636387plr.70.1583162953095;
        Mon, 02 Mar 2020 07:29:13 -0800 (PST)
Received: from cisco ([2001:420:c0c8:1003::427])
        by smtp.gmail.com with ESMTPSA id z6sm38762pjd.34.2020.03.02.07.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 07:29:12 -0800 (PST)
Date:   Mon, 2 Mar 2020 08:29:09 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "Tobin C . Harding" <me@tobin.cc>,
        kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/mm/init_32: Stop printing the virtual memory
 layout
Message-ID: <20200302152909.GA7777@cisco>
References: <202002291534.ED372CC@keescook>
 <20200301002209.1304982-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301002209.1304982-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 07:22:09PM -0500, Arvind Sankar wrote:
> For security, don't display the kernel's virtual memory layout.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Acked-by: Tycho Andersen <tycho@tycho.ws>
