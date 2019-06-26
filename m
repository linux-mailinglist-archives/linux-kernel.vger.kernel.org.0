Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E5356D96
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 17:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfFZPZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 11:25:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50277 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfFZPZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:25:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so2555005wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hUrLpFjxYsSye8DlerGP/4UbAK7TW/gORsGDWMbyLBs=;
        b=SCJ0fZCdTOxengu7vee9R/jq+qhvNjkLrpRKrIFPxtjSq//2fsA9WoC53/m2omdync
         qZ8e7G2iYtnE3PiL89QSKu8vGnfY8hGhmA7i5KRvb6yLrK4VYoaZwgKN8qHzSEy49AoE
         QzVs7xgqDLfQLFx1yYsI3bkOsTvnBoZTXczK++HcnvUpDkTFlXtp4Z2kiHQU84Meck37
         Ha5oKwI6xJlgrZHxzsKoc64UPFmh13K4vh2kK3JChy+tBBGvipgWAK/yixp+LVo7ErHw
         BqsmU8xr7Nb12Tqj+VzGIGsweNLTanK0F8yiiIy5hVSgGvBlJ9BJtf/6CaoYeXxCuZNY
         u9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hUrLpFjxYsSye8DlerGP/4UbAK7TW/gORsGDWMbyLBs=;
        b=IQzDRThfpcruXJzojS98S4h61ygLWPMn8TxO69uhIY4q2Gkk9bN6ajaqTeyNa8qpLE
         4IhIuGUuvlqggZZmhTVeqQn+Tls/mKRP9vtJ3ejmyE+ZQMM6cRsayJXhK0Gdtg1+Z+3H
         3k11jqAz2RxbniKU/BFMhNDnzZOy1UBIP6co7haP1rqMrClknmujtmU3stISFkPJzsCN
         PDoAlcvQIvmcYyN87KaH/DVTDOHWAhqJwehaAWoQS+ajoc6rSPrGB6u9NG7dszh14fhA
         C5XgZU5/J91ZTE/ojE8Cbsk0ug3s7IOgJBjpHSNfUq2TrdR3LloJodibv08O58/OU06C
         hy7g==
X-Gm-Message-State: APjAAAUpV6nxqbkY0nvBLp8+w+sgAdNuXHzuIr1x1/t2wC8U00aiLp35
        FZvQiFpOksjF3wMDBuuklm/EJg==
X-Google-Smtp-Source: APXvYqzD3QddXeSn6DuAIyxnlAIDaLA7cl2h50Pmecv/u+lA3k1zUFNV80Hb1q4R9BHR1FehrrZ2XA==
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr3046184wmm.108.1561562706872;
        Wed, 26 Jun 2019 08:25:06 -0700 (PDT)
Received: from localhost (ip-89-176-222-26.net.upcbroadband.cz. [89.176.222.26])
        by smtp.gmail.com with ESMTPSA id v27sm41854276wrv.45.2019.06.26.08.25.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 08:25:06 -0700 (PDT)
Date:   Wed, 26 Jun 2019 17:25:05 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, sdf@google.com, jianbol@mellanox.com,
        jiri@mellanox.com, mirq-linux@rere.qmqm.pl, willemb@google.com,
        sdf@fomichev.me, j.vosburgh@gmail.com, vfalico@gmail.com,
        andy@greyhouse.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] bonding: Always enable vlan tx offload
Message-ID: <20190626152505.GB2424@nanopsycho>
References: <20190624135007.GA17673@nanopsycho>
 <20190626080844.20796-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626080844.20796-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jun 26, 2019 at 10:08:44AM CEST, yuehaibing@huawei.com wrote:
>We build vlan on top of bonding interface, which vlan offload
>is off, bond mode is 802.3ad (LACP) and xmit_hash_policy is
>BOND_XMIT_POLICY_ENCAP34.
>
>Because vlan tx offload is off, vlan tci is cleared and skb push
>the vlan header in validate_xmit_vlan() while sending from vlan
>devices. Then in bond_xmit_hash, __skb_flow_dissect() fails to
>get information from protocol headers encapsulated within vlan,
>because 'nhoff' is points to IP header, so bond hashing is based
>on layer 2 info, which fails to distribute packets across slaves.
>
>This patch always enable bonding's vlan tx offload, pass the vlan
>packets to the slave devices with vlan tci, let them to handle
>vlan implementation.
>
>Fixes: 278339a42a1b ("bonding: propogate vlan_features to bonding master")
>Suggested-by: Jiri Pirko <jiri@resnulli.us>
>Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>

Could you please do the same for team? Thanks!
