Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69483CA71E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 18:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405968AbfJCQuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 12:50:46 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:34985 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404434AbfJCQug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:50:36 -0400
Received: by mail-qk1-f174.google.com with SMTP id w2so3060128qkf.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ugrakjKATdtEjJWn4tk6YlL3Okyto1CddfouAPmaV54=;
        b=oO2VLgtqJ29OYQYQU1McnBMDLGkBdFgfD437kzpMWJzqazZ8fTH23PwceQ9Ho6hsd1
         DVPKYd0YZBG2ATvRVNLH0nOYeUDMKDyDC17p91XWV4YmNCvXK3Rp4DcHvs8sRr1yLbhq
         HjJB0tmSD0r3AvOcvE/MVY8gFEocsV44G2But+/65voOg0m0CWg9qMg9MlpCQYzHs3zJ
         TRAz0GznLjDF2VuAGZyLZH4KTNp4Ckr1wr0vyaKniCT5lpe6HVbyRneyvnHgAKFh0XLh
         HSzuiRjXhqof6YHqVmxYgYuIhLWhou0DTVSczwgeeTLBlde247fvdqjZ2BnAEetj3Skh
         XAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ugrakjKATdtEjJWn4tk6YlL3Okyto1CddfouAPmaV54=;
        b=UVvF4n/Vo8inVG5kZN+rsuWljEpyUOHrcD7i6z07G++0RbtWVST4vKcgGY6uyp2P0i
         99NSCxWRq4FCJWZ6Pz79SauzfZnOWykgJXQsx6aMsgGtZkkpEgtri9gs9vcDj4vgmsXN
         FD8HuYVkNvecoeHJWlrTNWHIKpnUlbGkOc6muFfIcKDTtQWie0MWNCHU0DCKOd0RI9j0
         w8pyj2LhtOi/sq5Vokz4sFtqZouogF+i9U+VUv4sN3F+qf2ud4Cazo+PXQ8D2cOhqdl+
         x6BmfDuBnGeNfiv6nVypya4Shx4ylAerWHzdix5E7jWrz6TvJgDJP8Ebkuo0pf4F4oJo
         SwGw==
X-Gm-Message-State: APjAAAXLIQjbvdfabBDJME30mYKRX6YYJqfIYv6wnpMJLgRQzBMMEcQY
        1vAaRbnrBpuUyi4l0huJGQA=
X-Google-Smtp-Source: APXvYqy3IUsNtIUDdRBNYMhYcL0tTzAp9RWFjebbkNcHItrzLdaQkF80DRHAMGLXzteuta2rw+jJ4Q==
X-Received: by 2002:a37:4cc7:: with SMTP id z190mr5273064qka.458.1570121435276;
        Thu, 03 Oct 2019 09:50:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:9f72])
        by smtp.gmail.com with ESMTPSA id 207sm1891576qkh.33.2019.10.03.09.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 09:50:34 -0700 (PDT)
Date:   Thu, 3 Oct 2019 09:50:33 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: System hangs if NVMe/SSD is removed during suspend
Message-ID: <20191003165033.GC3247445@devbig004.ftw2.facebook.com>
References: <20191002122136.GD2819@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002122136.GD2819@lahna.fi.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Mika.

On Wed, Oct 02, 2019 at 03:21:36PM +0300, Mika Westerberg wrote:
> but from that discussion I don't see more generic solution to be
> implemented.
> 
> Any ideas we should fix this properly?

Yeah, the only fix I can think of is not using freezable wq.  It's
just not a good idea and not all that difficult to avoid using.

Thanks.

-- 
tejun
