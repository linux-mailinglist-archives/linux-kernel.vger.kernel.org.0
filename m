Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAF2823F70
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 19:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfETRvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 13:51:08 -0400
Received: from 11.mo1.mail-out.ovh.net ([188.165.48.29]:44887 "EHLO
        11.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfETRvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:51:07 -0400
X-Greylist: delayed 19201 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 May 2019 13:51:06 EDT
Received: from player735.ha.ovh.net (unknown [10.109.159.62])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id EFCB617951F
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 13:53:30 +0200 (CEST)
Received: from RCM-web1.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player735.ha.ovh.net (Postfix) with ESMTPSA id 541335F67566;
        Mon, 20 May 2019 11:53:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 May 2019 13:53:18 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     arend.vanspriel@broadcom.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@cypress.com,
        wright.feng@cypress.com, kvalo@codeaurora.org, davem@davemloft.net,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wireless: fix typos in code comments
In-Reply-To: <20190519032256.19346-1-houweitaoo@gmail.com>
References: <20190519032256.19346-1-houweitaoo@gmail.com>
Message-ID: <6cd5d69d936ba2a2033041bcddb206e0@milecki.pl>
X-Sender: rafal@milecki.pl
User-Agent: Roundcube Webmail/1.3.9
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
X-Ovh-Tracer-Id: 10752907064325344891
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddtkedggeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenuc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-19 05:22, Weitao Hou wrote:
> fix lengh to length
> 
> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please use:
git log --oneline drivers/net/wireless/broadcom/brcm80211/brcmfmac/
to see how patches for this drivers were subjected in the past.

Please resend V2 with a proper prefix instead of "wireless: ".
