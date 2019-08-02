Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA2C7FB92
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 15:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbfHBNwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 09:52:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35583 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfHBNww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:52:52 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so152361291ioo.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 06:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iiE3sHGr9W6BkH2HZAGFVA8ZeEJu1z8jPDMZlXOMZiQ=;
        b=VGsKRk1nB32lpRI0EqXJ/sGsF5JNij4yzKW9htjLHQSg6oQtHRrSoBFn8xMx1hAkxH
         I2mCwaZ19FUgvNgssmlx7iGGuuEHf0OK/Ftywy5IuDgV3EmUsVKW1m1f7GWZMWgIk2HQ
         A3nTFAc9r05zjzgb8+8eUB6wBW7nWMoU+pOXzWr8vwjrw6GFrZKGjF6ptYi+uD5PZiWW
         qKiT//NybKclz1ThVBU4U+IojU+ge4eVGZ8trc9ZGD+YE9w8kKS78u+T65qU2tICRSvH
         FnaHGeordZ4Zw+bdjub3KHUINPKpHegERV4DaY6KFJ305nI9CfQ4eBfakphIrCU0nnV+
         tMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iiE3sHGr9W6BkH2HZAGFVA8ZeEJu1z8jPDMZlXOMZiQ=;
        b=uKASs4OEpO8TBhK6alwFe9PIv6igsly53rEQwFLnDMzGG/7AzighATtoIUCtp3RDQW
         Rv/ih1c0kcnLc5DAiJc6aS6jft16BLp5hi1I+GPOy6mmF5dc2SsUj/7PPcJtHjFAFO9j
         n2yR6/8ckYZ85eOPKxZ8jTxQ6oRTFFjeARMuBr92ddSgtzwcXWK56FSYd7aJ2m4S+u5v
         WoS2YdgXbCqIz5/2P8GJFiwJOCrz6MYfVVZoCsAkahL8y2KnF0Qm3t9pO2MIp2H1fj+F
         aQcZhkLtGOc5e8D9PwjD0ilsReP5d5FBNptG6/GFAM01d50kt9eAmcr2mBXmfortqJot
         9fJg==
X-Gm-Message-State: APjAAAWIpcr/NRf/k8OL12H3UkT8Jv2WtXVY24isMh4Hm7rq3ZZGvDxQ
        mzi7kKJd+Olf+buKiJMmNgc=
X-Google-Smtp-Source: APXvYqxCtim9cD3AK0m0lLUd5xUX4EFJRW0TFUi7zS7pitDITUzYoPEwEKaVimmjU3GqKrBXL/Ve2A==
X-Received: by 2002:a6b:f906:: with SMTP id j6mr42026864iog.26.1564753971837;
        Fri, 02 Aug 2019 06:52:51 -0700 (PDT)
Received: from brauner.io ([162.223.5.78])
        by smtp.gmail.com with ESMTPSA id h18sm58706673iob.80.2019.08.02.06.52.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 06:52:51 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date:   Fri, 2 Aug 2019 15:52:49 +0200
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v2 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190802135248.gbtkh5sgjzmbup5h@brauner.io>
References: <20190731161223.2928-1-areber@redhat.com>
 <20190731174135.GA30225@redhat.com>
 <20190802072511.GD18263@dcbz.redhat.com>
 <20190802124738.GC20111@redhat.com>
 <20190802132419.GD20111@redhat.com>
 <20190802134611.GF20111@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190802134611.GF20111@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 03:46:11PM +0200, Oleg Nesterov wrote:
> On 08/02, Oleg Nesterov wrote:
> >
> > So Adrian, sorry for confusion, I think your patch is fine.
> 
> Yes... but do we really need the new CLONE_SET_TID ?
> 
> set_tid == 0 has no effect, can't we simply check kargs->set_tid != 0
> before ns_capable() ?

Yeah, I agree that sounds much better and aligns with exit_signal.

Christian
