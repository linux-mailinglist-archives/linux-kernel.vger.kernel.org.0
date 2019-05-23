Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1874D276D6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 09:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfEWHYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 03:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfEWHYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:24:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A9A7204EC;
        Thu, 23 May 2019 07:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558596261;
        bh=p1vx5T5TzR7Lt49i3nph2k69PblDSo4eJT1e5+vVKFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0NizurRKh/LVy/gfKuBw6BnaROB/rIJmFEDnRO6WE3pIyryAlxvgHfzsTq9jfzlV/
         rEFK77NOvJtKfCyk08urfr7i0+cNzSVbxkPMPJHLeDwuhAiPAV5S//L+o/ARmc1mGP
         coeET8lLa/NY3muQOIy+NdWiudwGLrIh/3AlVgi4=
Date:   Thu, 23 May 2019 09:24:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Murray McAllister <murray.mcallister@insomniasec.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Kimberly Brown <kimbrownkd@gmail.com>,
        Anirudh Rayabharam <anirudh.rayabharam@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Omer Efrat <omer.efrat@tandemg.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Straube <straube.linux@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: rtl8723bs: core: rtw_ap: fix Unneeded
 variable: "ret". Return "0
Message-ID: <20190523072419.GA5628@kroah.com>
References: <20190522171137.GA5579@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522171137.GA5579@hari-Inspiron-1545>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 10:41:37PM +0530, Hariprasad Kelam wrote:
> Function "rtw_sta_flush" always returns 0 value.
> So change return type of rtw_sta_flush from int to void.
> 
> Same thing applies for rtw_hostapd_sta_flush
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ------
>  Changes v2 -
>        change return type of rtw_sta_flush
> ------
>  Changes v3 -
>        fix indentaion issue

This patch does not apply to my tree.  Please refresh it against the
staging-next branch and resend.

thanks,

greg k-h
