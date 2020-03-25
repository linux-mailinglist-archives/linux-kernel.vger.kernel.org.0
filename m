Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC016192D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 16:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgCYPwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 11:52:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36289 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbgCYPwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:52:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id g12so3026691ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 08:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FFKgDeHvhTCS00AQN8L5xpmPeeM6E1oKLK7azqnWDiE=;
        b=uicKA8wIvWFlXoj/N3LEYBm1C4A3V4P9iw9tec/gYSHrhStzUBQCHg9572Xte1kjgR
         ThMBTvZUPKiWKz7FpDL5FpZdKIk2YCmk4xT9mv8vXzDYbG7BnewAeqmTmjbMblvWal3H
         mWL8hgD8rxlqA3cc+cD7G6ybnkogU1aJ7AGejI0PI8JR5OHaQ8Yinse9H4h+GK2Hb1A4
         AO25iODgSANaemv90W5sSFYFQjzOpxBoKLIe96Vf8WjB/zrqJX1NEJY7yq750pQkaqOk
         1+9OYeGLNZxl0e6F3esYfat8n9CQbuKfwTbzDvu3Chf0eeKLqiEo59Jx1mNdOEbnZcqK
         7RZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FFKgDeHvhTCS00AQN8L5xpmPeeM6E1oKLK7azqnWDiE=;
        b=C6sBNnfxyzMepl+HITtSOc0CZnOM10uDzxkz6PcMdOnCBq0g5qMcN5BaUZdxwxw+2A
         eK1rpN3TnH1gAamgb43XDi8g4awDL/6DQKkSrYFQQtGj1LHoO4qtSBGu+k+OAnGbrzG4
         OBB2a7QNluQuLa7q5/GOroNw5wZETqnABcTBRPV+fmcrNqkc2OMs/bnP16IYlat9Tb0B
         bLFjN46WiBMOXZV9yTdjb0/e0qF7nwV/OQSwuEh47Ek5WH3YGSGw2Bfc6T4yFpbbI5yv
         Gl39gqvcA7kzlp6hEe5jxLse3TKf9QRbqy43OItH1ibx0ThSwE7vEZ8m5FZWGcNQG7eN
         Hp2Q==
X-Gm-Message-State: AGi0PuYNElIjruLWX5L5yqzD/AkyuACMTnZdN6nwImHOs1woQFhD9/tE
        T8RSPVCpaxw5Iha145N82z2bbQ==
X-Google-Smtp-Source: ADFU+vv75ZUwXg2vEi4sa3vjU/XvBmaxBeQGnk0gRxgFefclx3FSltiYeD1SYorsoysNlfqIA2nFcA==
X-Received: by 2002:a2e:964e:: with SMTP id z14mr2510095ljh.44.1585151522265;
        Wed, 25 Mar 2020 08:52:02 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:4678:2dac:733f:487d:7a84:7bac])
        by smtp.gmail.com with ESMTPSA id l21sm275175lfh.63.2020.03.25.08.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 08:52:01 -0700 (PDT)
Subject: Re: [PATCH 1/4] ubifs: remove broken lazytime support
To:     Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <20200325122825.1086872-1-hch@lst.de>
 <20200325122825.1086872-2-hch@lst.de>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <3771d2fd-b563-b74d-491b-e2bab9242126@cogentembedded.com>
Date:   Wed, 25 Mar 2020 18:51:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20200325122825.1086872-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 03/25/2020 03:28 PM, Christoph Hellwig wrote:

> When "ubifs: introduce UBIFS_ATIME_SUPPORT to ubifs" introduces atime
> support to ubifs, it also lazytime support, but that support is
                           ^ includes?

> terminally broken, as it causes mark_inode_dirty_sync to be called from
> __writeback_single_inode, which will then trigger the locking assert
> in ubifs_dirty_inode.  Just remove this broken support for now, it can
> be readded later, especially as some infrastructure changes should
> make that easier soon.
> 
> Fixes: 8c1c5f263833 ("ubifs: introduce UBIFS_ATIME_SUPPORT to ubifs")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
[...]

MBR, Sergei
