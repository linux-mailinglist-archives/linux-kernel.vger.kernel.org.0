Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2601139944
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 19:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgAMSr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 13:47:59 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38174 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgAMSr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:47:59 -0500
Received: by mail-qk1-f194.google.com with SMTP id k6so9512432qki.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 10:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IZ250V/yBJXsxGldcJDuZlPmLepYVLSagti/+427jTY=;
        b=nccjm31vjv/xgP2M2c6sqmUGExzvdc0L1Uym/253T6le52hgsAzzdtNdH4kXF5fBGc
         q07IXzAjvWYRmFa28acgJI0WMjaPtoRjkNFUcu5cZ/gLTjwhnAH59pvIbSgftB79IFEY
         2OrKAZ9GAmuYlYBv7hB7SIyubrSJN0yK+JKMtbqVapxNnmcfNyZo8Xj3wjgRkSZZoo4H
         qig2lGBsO/JLiunHiGPvyDemeUEQiR7M4wIcZWcfMgWJ9avMc3XX8pUCqEKTL9uLyeUx
         HDDkrvcTpSarYfneQPRSWE9sTcDv16mqVP5fjGxAPYXF9NNC1rdq/j8nt+GkvatHZdwc
         NiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IZ250V/yBJXsxGldcJDuZlPmLepYVLSagti/+427jTY=;
        b=P8T+jkn/Aox3knqWVLZOWH8i6OUwIYna7IGJNjmOZdKKsRlqyE7doh7AbkZNTptYnm
         RGjCbSvSn2R/GXiNdb+5UGh5t/co9IKGtXYRsgRDcQN7XW+8xffZThcDL4hh7rUOa+jY
         dNFZIhFSqfzebRIV4KrCdGj0jb6Cb4mSyE5p1cx3QdReYUmy8VjEbcVVFxApiqQhWWmV
         XZnAybm82xrv3P73IfJiy6HCH7lICYb4V99ZFhXwIm9O4SMFsnhnxjgsc938tUL2icJJ
         bVpJsGuR8atoF1k3kneYX+/W8v/R3gBXJ3Lowk344NF1YkzXMJ3oB1yNodZX+H2sip6t
         K8dA==
X-Gm-Message-State: APjAAAVqqVWolyauMggZY9OY/0VG7UOxUKO4b1fGlwGpBRlS0lZk92vG
        cQhK+B0QKzV1XY1A1iAkhldFcg==
X-Google-Smtp-Source: APXvYqzzUuNaLJaXuS085J1ea6O6R9Y32BSTOXxN2+5SwkIyxc0tb+ytOESvgORqHBQYtyWVY0Xqfg==
X-Received: by 2002:a05:620a:102e:: with SMTP id a14mr16996145qkk.159.1578941278397;
        Mon, 13 Jan 2020 10:47:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 3sm6139227qte.59.2020.01.13.10.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jan 2020 10:47:58 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ir4kn-0004ve-Ep; Mon, 13 Jan 2020 14:47:57 -0400
Date:   Mon, 13 Jan 2020 14:47:57 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Rao Shoaib <rao.shoaib@oracle.com>
Cc:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Introduce maximum WQE size to check limits
Message-ID: <20200113184757.GB9861@ziepe.ca>
References: <1574106879-19211-1-git-send-email-rao.shoaib@oracle.com>
 <1574106879-19211-2-git-send-email-rao.shoaib@oracle.com>
 <20191119203138.GA13145@ziepe.ca>
 <44d1242a-fc32-9918-dd53-cd27ebf61811@oracle.com>
 <20191119231334.GO4991@ziepe.ca>
 <dff3da9b-06a3-3904-e9eb-7feaa1ae9e01@oracle.com>
 <20191120000840.GQ4991@ziepe.ca>
 <ccceac68-db4f-77a3-500d-12f60a8a1354@oracle.com>
 <20191219182511.GI17227@ziepe.ca>
 <6da00014-0fd2-c7fc-93ab-7653b23aeb1e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da00014-0fd2-c7fc-93ab-7653b23aeb1e@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 10:35:14AM -0800, Rao Shoaib wrote:
> 
> On 12/19/19 10:25 AM, Jason Gunthorpe wrote:
> > On Tue, Dec 17, 2019 at 11:38:52AM -0800, Rao Shoaib wrote:
> > > Any update on my patch?
> > > 
> > > If there is some change needed please let me know.
> > You need to repost it with the comments addressed
> > 
> > https://patchwork.kernel.org/patch/11250179/
> > 
> > Jason
> > 
> Jason,
> 
> Following is a pointer to the patch that I posted in response to your
> comments
> 
> https://www.spinics.net/lists/linux-rdma/msg86241.html
> 
> I posted this on Nov 18. Can you please take a look and let me know what
> else has to be done.

You mean this:

https://www.spinics.net/lists/linux-rdma/msg86333.html

?

Don't mix the inline size and the # SGEs. They both drive the maximum
WQE size and all the math should be directly connected.

Jason
