Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDD3E894E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 14:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388444AbfJ2NV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 09:21:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42781 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfJ2NV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:21:27 -0400
Received: by mail-qk1-f196.google.com with SMTP id m4so12133467qke.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 06:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1YpYMICvtfF10jHRaLvbJtkSuykMWavtIqdMoqx0V/U=;
        b=WHQJCFkajK2zHSstOrIxbWsS1IvSJSZMSpBhufG6qZpWrgzSB9vqgMRV9FGitJYID3
         bPuu5YirlOH/CAnekaWkyG9Bw7BYn+sMMGtZ76XGjzwGABnqiWl/pRMk/nP6B4hd78o8
         DAYufsmEBg4Ujd5vLGNfzqa/mB/dOgbi1h65CTvP2k9tZEItx6Tm7+pDyg0DIblUd5lo
         uchd5GkkZ2gM5KBcgd2UaMEb+9DwZNoEDtpWUR657Il+c0C0qwo0xceW5l/yIzdhIrvF
         IPJFVTia5E2YkKDqqHlLOn8dfU7BhuAOPPe/+jhpwjlbB8f+KO/p4UpOFPHFJUFT9R/1
         kPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1YpYMICvtfF10jHRaLvbJtkSuykMWavtIqdMoqx0V/U=;
        b=lB/03hfMWBYF2bXYmi2T1i2PiZvdhTqi2Lt9e8LfCdKe21uwPNzz2QOpMJPOxJtTvJ
         E0t5okQABAGmk2Tn2sDlHBDJNACrEBFS8VkomAbmHc4MOEQyjsnJCHsA3cOCAFTJT/po
         DcCtQnTRYi3pjHF7khe85PHuoAaG9tgDy9Kcef8PqkHSUEFuBiWoDUedzxft8On4o8wz
         DMeMpCjFxnqv54xJeRLxxWrc9vmODJ+kjPNFQQ82Yr8p8+73kPnK+NoSYWv7dJpdM5d5
         dp/BxYFNkrYCTh/qBCCAXnX7BzchGIg50oiEg4UTxVY/HZU59poEAj0hqkFbvgwajrlJ
         iKOw==
X-Gm-Message-State: APjAAAUj94fVn6uPN+Hnluete8Aa5OnF1MrMSJjhfciIo7QXmLStH/yn
        dN236fNoP9peqs9ov1fDZgTOmqv5
X-Google-Smtp-Source: APXvYqx0BOZQSNWo73uAIj4uP76Zzt3szUQBma2RA7YgmozEJdZFx6MmGa+BCjmQN42dru7I3hLL4Q==
X-Received: by 2002:a37:9e89:: with SMTP id h131mr21656614qke.477.1572355286090;
        Tue, 29 Oct 2019 06:21:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::8ce9])
        by smtp.gmail.com with ESMTPSA id o2sm2083929qkf.68.2019.10.29.06.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 06:21:25 -0700 (PDT)
Date:   Tue, 29 Oct 2019 06:21:21 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] fs: kernfs: file.c: Drop the condition with no effect.
Message-ID: <20191029132121.GK3622521@devbig004.ftw2.facebook.com>
References: <20191029095552.GA11561@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029095552.GA11561@saurav>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 03:25:52PM +0530, Saurav Girepunje wrote:
> As the "if" and "else" branch body are identical the condition
> has no effect. So drop the if,else condition.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>

Nack.  Please read the comment right above.

Thanks.

-- 
tejun
