Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989E317EC65
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 00:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgCIXDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 19:03:50 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45448 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgCIXDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 19:03:49 -0400
Received: by mail-qk1-f195.google.com with SMTP id c145so5220893qke.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 16:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DG5Pmu1RlQqHBWl+2qUX5CoGznFuBPO5I6Xwyxwb+Cs=;
        b=gyPUS950qwVdh0+braV/e3jgiwyl9rKeMblixJMxHnbVM14lXi0z+IVb1BLL5qohGB
         Oj1x2W/5X1R4dMQUKlvVgKlRrgpGVWXRJjsDvt3nI/eDWNEzJI1ZBLb/1mFdGII05Qoa
         N6kOMSXBHafiqYJKag3k4o3UIJsI6B4CPraCKX7ZqIN4Wz3SC4XboMQKljz2gZmSWZ/h
         Va11KdhuaGezvM3vV1fmFfxIL4z+Y+2FMtXNgTHiMocYpIZ8u2JaFHLbKqSh/gMI0CS2
         oLVN2kEAVhszQoBMkC693ll3B6py0pMcBDAOepqOVTDEEhPXsNbxXH6mBTI4ddpE5gAP
         LnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DG5Pmu1RlQqHBWl+2qUX5CoGznFuBPO5I6Xwyxwb+Cs=;
        b=Xe5NA7VUMf/znMRCrWAQYfhGAsYcOZCRIWpsUrvYO1sWd4Uc+ZA7uVTe/Flv2t3swy
         GhHVjheVL71dHFBj9iigVXqplPUJmn8MygmJTlVfNJIONQYeLXZYvk9evFs8WGJt+TFI
         CSKZtwYcUmyGqaF0yAeaWvHdFFVdI9SV80RCrYur0FWTETMJ8f7qPMtnpZsUpxhB/E7Z
         7+wIdBBpMMC8Ud6t0DMYqw57qy9P8qBDciWIww+5zGCuNBtq8PcC4gxqPq1QF/HlXbKg
         aJPqSB886Y0GSBYIpqyjHXiVRLYPYpVWCTWWlWhVSTy80iNRSS9CRm+J+lRWLtvb53iu
         wX1w==
X-Gm-Message-State: ANhLgQ2rvk6jAh8RPiVZi0NxS/3lCl6wj/5Rs7a6EtN1vuH+VNeg/EJa
        LW3GFbbbILBn6/j0iJkBvg4DCw==
X-Google-Smtp-Source: ADFU+vsVuThcYSPMT2Kil8KJF1J3XD2L42eeVKLwA6rk3nlN3INK1pTC1Eso1Jbfa3D4sIWSdor1Jg==
X-Received: by 2002:a37:664d:: with SMTP id a74mr16712041qkc.256.1583795028784;
        Mon, 09 Mar 2020 16:03:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id q142sm3151748qke.45.2020.03.09.16.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 16:03:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBRR5-0004ho-F5; Mon, 09 Mar 2020 20:03:47 -0300
Date:   Mon, 9 Mar 2020 20:03:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+06b50ee4a9bd73e8b89f@syzkaller.appspotmail.com>
Cc:     chuck.lever@oracle.com, dledford@redhat.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: BUG: corrupted list in _cma_attach_to_dev
Message-ID: <20200309230347.GY31668@ziepe.ca>
References: <20200309172430.GV31668@ziepe.ca>
 <0000000000007dfeb705a071ba51@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007dfeb705a071ba51@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 01:20:04PM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger crash:
> 
> Reported-and-tested-by: syzbot+06b50ee4a9bd73e8b89f@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         0aeb3622 RDMA/hns: fix spelling mistake "attatch" -> "atta..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b58f96e9824c82cb
> dashboard link: https://syzkaller.appspot.com/bug?extid=06b50ee4a9bd73e8b89f
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Note: testing is done by a robot and is best-effort only.

#syz dup: KASAN: use-after-free Read in rdma_listen (2)
