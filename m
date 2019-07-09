Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2D4A637CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 16:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfGIOWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 10:22:11 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:46378 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfGIOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:22:11 -0400
Received: by mail-qt1-f174.google.com with SMTP id h21so19582185qtn.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 07:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZOJuPULlrE2vBj/9c6KgmQ77330wz9gdrf5HX3f8siY=;
        b=JDFVm5GfySg8Sd4dZ3vDpuc/MVCMu8c1Ktmjz2sipL5/bYCXthqdqTfl0bNqoCBCI1
         dC7Dtu4MtLf2FqM7JRoqn0A/nQvL6M8evor8AgzJK/w1CufgGmOorzJZHxvCCl9aHaBd
         4wDo7PBrRPXRTNWy4BIhCqgjQ8DqP39asU5NJ1ICrNyqUtBSlfDdcsa3VmeMvjtsIYMx
         /K3MgQfRw9h/p4QB2k7JpAgjFcsjru4n8+zEKkoILGXOc9kVEIKqfX91oNercxLdtLa/
         ay7BjWlyoaz8EGyUH1HyGJgey/unBEiisACqinSU5ZD8z+5t/cdODiPdGMSk6sQqIZhB
         x1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZOJuPULlrE2vBj/9c6KgmQ77330wz9gdrf5HX3f8siY=;
        b=nqmoBQqUPWIWLmX62UU6AHExF4bksz0LhxmqaiZI/tATDmsknjP1lpmA64hN8Aq/ID
         V1AQh/s/8aAkc9YObaXZ8J6AsvHnNucQCZqP1uqbaGntH4gX8aBVSfN7hvyVl9m0/MPh
         NS4mD/Rqsco86FrpQEH4kZ+rWycNbA6D80/1iIXSKS6BGCp/7LeyhQ+MPvpYiEooolWb
         zJPgSt2g6z7Uy0L8hpCkJDRS0bAhbQ/gvYGrnHrnhPvb17jl/9XVyU59UJrqBx+7VsER
         Cqog3QMP+4amnZ5H09U/Fob8Yh2NLi+5MRBSdrDCuBXr17aOJve3CK2TK1x2YC43K7VT
         K/0w==
X-Gm-Message-State: APjAAAV0Fj2gC4iVfbUN3dEWaK81k/xeelcz0IZIg3DcwP+uQhMCKKxF
        xj/PwUQjHKok8N6cVLjUud8=
X-Google-Smtp-Source: APXvYqxhZ6GaC0CzKYNXaWrldMUxDF2XzrreMcfaj5I6XaPJLQ6R+7EpiOkA1wtD/Y1dkMTF1J3YhQ==
X-Received: by 2002:a0c:e1cd:: with SMTP id v13mr18273199qvl.245.1562682130349;
        Tue, 09 Jul 2019 07:22:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:fa50])
        by smtp.gmail.com with ESMTPSA id p4sm9672337qkb.84.2019.07.09.07.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 07:22:08 -0700 (PDT)
Date:   Tue, 9 Jul 2019 07:22:06 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+38f5d5cf7ae88c46b11a@syzkaller.appspotmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in kernfs_create_dir_ns
Message-ID: <20190709142206.GI657710@devbig004.ftw2.facebook.com>
References: <20190709022335.12928-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709022335.12928-1-hdanton@sina.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 10:23:35AM +0800, Hillf Danton wrote:
> > I don't think this is the correct fix.  It's being called with kobj
> > whose parent's sysfs node is dangling.  It gotta be fixed from the
> > caller side.
> >
> Make sense?
> 
> --- a/lib/kobject.c
> +++ b/lib/kobject.c

No, I meant that the problem likely is in the driver which is calling
into the generic layer with a dead parent.  We shouldn't be working
around that from generic layer.

Thanks.

-- 
tejun
