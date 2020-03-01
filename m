Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF29174FA1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 21:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgCAUqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 15:46:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39042 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgCAUqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 15:46:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so9964520wrn.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 12:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R8Cp9xrpFC9LnRTFPg+iYo0rybRv3U6fl7Gsce1rPn4=;
        b=inPbh0kCxpta0P7iizPVlvgiRVuYW173A2/muoyK/hgn8gnPgDqxQ4jJf4Acim+kpH
         ZkWEH4pz8U285bztZ4H6Gwjm/dXaboc4GFUiHeZZavhdaM7sLlfv6sfj7AUAiXoV3nkt
         KH2Dc5LcfWgzT/VhSFPnxw74lYROuDf8QAxbE5HWXpLjVMIuXe+LgWCNWHYNaqRd5VfH
         hYQPveufyu+snTY0gWvAXP1nNX/Ge+3u0yLChtQQvjiTnVYvMrOPu4vJ1oa5y6D8jjFV
         3Ba8i02LDtkqyF7dC06gIgdkSMIdJPoThGv6kqit6GSSQZGJJ7mwxNYU8AJfY47Dh1oH
         A05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R8Cp9xrpFC9LnRTFPg+iYo0rybRv3U6fl7Gsce1rPn4=;
        b=KB6xGaN8GTWgWk9Ebf8C154bBrsvu/g/p8rFpNj9jEfUmPfThMQqKf4FGclZPL47MY
         SLIcl9vhF0jcDOLYKcEPBuf3h2Ii7gXpcYJY8DSEoPGYBnyV+9Jnxv2NP5ORg4KM3b9/
         QrzMFZkXLfGAwq9Hd7devLaizTE58CHiJZJkhrj06YOS9W7GfgSP71TseMvJLSHv0ceo
         3IWl71dUtVPNXbXXcpDfie/fUWqKjT68lQzsA3lAprpfL0nFhMrv6yixyaLGiXKusbNQ
         kr93GX2c1PvOrFyH6YitGPJTY1ozePTF89+oWeKURgs1dC3ve555o/YTCcCTkOPqGflw
         sIIg==
X-Gm-Message-State: APjAAAVJJHtWT2iV8x0m1H1RCtZF4mFfZZhMEqD/YDLlb/3DQiDEOXXN
        AGWVaaVDX2UO96Kx0Jvk1qqifsf11eARfmFUSzs=
X-Google-Smtp-Source: APXvYqyws8Bwqoi8nGAxIprcQ5NwNup7jSWTqHrVs2J4Gnxg7/74CCPZd9CuXAfRsqDTlS4A5z/6wcm5OKbeAzjBveg=
X-Received: by 2002:adf:df8f:: with SMTP id z15mr17541906wrl.184.1583095592473;
 Sun, 01 Mar 2020 12:46:32 -0800 (PST)
MIME-Version: 1.0
References: <1582293853-136727-1-git-send-email-chengzhihao1@huawei.com>
In-Reply-To: <1582293853-136727-1-git-send-email-chengzhihao1@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 1 Mar 2020 21:46:21 +0100
Message-ID: <CAFLxGvyJdWcXQt3H2aknTuGhCJpV5YvAbW_wuHfs3m+KcNSjtw@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Don't discard nodes in recovery when ecc err detected
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "zhangyi (F)" <yi.zhang@huawei.com>, linux-mtd@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhihao Cheng,

On Fri, Feb 21, 2020 at 2:57 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> The following process will lead TNC to find no corresponding inode node
> (Reproduce method see Link):

Please help me to understand what exactly is going on.

>   1. Garbage collection.
>      1) move valid inode nodes from leb A to leb B
>         (The leb number of B has been written as GC type bud node in log)
>      2) unmap leb A, and corresponding peb is erased
>         (GCed inode nodes exist only on leb B)

At this point all valid nodes are written to LEB B, right?

>   2. Poweroff. A node near the end of the LEB is corrupted before power
>      on, which is uncorrectable error of ECC.

If writing nodes to B has finished, these pages should be stable.
How can a power-cut affect the pages where these valid nodes sit?

-- 
Thanks,
//richard
