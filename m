Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877215C6F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 04:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfGBCMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 22:12:33 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33291 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfGBCMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:12:31 -0400
Received: by mail-qk1-f195.google.com with SMTP id r6so12779632qkc.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 19:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=cj7wYTbvxnOnmHnqTJFv0AkyAjuHBNH14abJUWzp+Go=;
        b=USO0exH9MPPma5wAH9tFFR07DfHKFygkjzscnPlfF1jZOmZudiBtyJUS5eZ8fc+SF6
         pvFf6EzLfmQ4bKj2ypW5EukVBjgcTxVuOQU4iUawamB4pyVKw6G+xIquQWyL+9bz0YF9
         nEJRYPJQrHXnFIEddwbXG/4c6vX02M0ykL/oVooYYqkdN+GNlVJ5FLGchHBqW9jdHoDi
         hpB2XKZakLzaHdREL2pYVTt8906FjaFvXcq3bDlcERPxbVUMOoIwZyPORSTuhQ87pvBa
         9GbzVCA7piNnINBAu8CXJWmsLJAMwkDqAMZEHIzC6TWYtWgCpuxMazSfwA0vJjSU4jvd
         Q7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=cj7wYTbvxnOnmHnqTJFv0AkyAjuHBNH14abJUWzp+Go=;
        b=QJhLfLN+8Az8hA2HkUcgemWilGeAdeA2QZw6QfiAD+4kxa/E2GTj3tjCEf4dQS7xN7
         M6iQJu61pvUA5pdZTiLXyhG6KbLdJwoXZFRsBMGjpyy7Vh7GTY83ZtGKlABai3jr+WBV
         /UiNtcn0N+8SeADvkyp602Jy/8y0Vz+KDKjIhZOlnUd6scIS28/JuqzksIX8UiICExRJ
         gl9upY32+fHIHLO4GDZukz9q3wp+wjo4M0zNAzx1Ob0ZP2+keWaWeNmr28kwOL0hRgTE
         KTMqDRSqlRy11EOlamAOyobT/JIM2ynIPigUkXs9uR2F+H9XUzOarf808Swdmc8fc6Gn
         /pMA==
X-Gm-Message-State: APjAAAVrZyrl22CveZP4EYKeV282BzbXR7RsSfeArI39OUqTbgRI7ySF
        S0G0TfJfMT7xOnNEWDZpVcsYCA==
X-Google-Smtp-Source: APXvYqw2RoGRLtjCCqUbo7Hx/iTMR8uEqpEDnFYow3PjRtVJX7gIQ/g7VPU8xWFpGep/veNhEy3c3Q==
X-Received: by 2002:ae9:e41a:: with SMTP id q26mr23331738qkc.361.1562033550408;
        Mon, 01 Jul 2019 19:12:30 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id o22sm5322133qkk.50.2019.07.01.19.12.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 19:12:30 -0700 (PDT)
Date:   Mon, 1 Jul 2019 19:12:25 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Xue Chaojing <xuechaojing@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoshaokai@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>, <chiqijun@huawei.com>,
        <wulike1@huawei.com>,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next v2] hinic: implement the statistical interface
 of ethtool
Message-ID: <20190701191225.68510307@cakuba.netronome.com>
In-Reply-To: <20190624120519.4ec22e19@cakuba.netronome.com>
References: <20190624035012.7221-1-xuechaojing@huawei.com>
        <20190624120519.4ec22e19@cakuba.netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019 12:05:19 -0700, Jakub Kicinski wrote:
> On Mon, 24 Jun 2019 03:50:12 +0000, Xue Chaojing wrote:
> > diff --git a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
> > index be28a9a7f033..8d98f37c88a8 100644
> > --- a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
> > +++ b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
> > @@ -438,6 +438,344 @@ static u32 hinic_get_rxfh_indir_size(struct net_device *netdev)
> >  	return HINIC_RSS_INDIR_SIZE;
> >  }
> >  
> > +#define ARRAY_LEN(arr) ((int)((int)sizeof(arr) / (int)sizeof(arr[0])))
> > +
> > +#define HINIC_NETDEV_STAT(_stat_item) { \
> > +	.name = #_stat_item, \
> > +	.size = FIELD_SIZEOF(struct rtnl_link_stats64, _stat_item), \
> > +	.offset = offsetof(struct rtnl_link_stats64, _stat_item) \
> > +}
> > +
> > +static struct hinic_stats hinic_netdev_stats[] = {
> > +	HINIC_NETDEV_STAT(rx_packets),
> > +	HINIC_NETDEV_STAT(tx_packets),
> > +	HINIC_NETDEV_STAT(rx_bytes),
> > +	HINIC_NETDEV_STAT(tx_bytes),
> > +	HINIC_NETDEV_STAT(rx_errors),
> > +	HINIC_NETDEV_STAT(tx_errors),
> > +	HINIC_NETDEV_STAT(rx_dropped),
> > +	HINIC_NETDEV_STAT(tx_dropped),
> > +	HINIC_NETDEV_STAT(multicast),
> > +	HINIC_NETDEV_STAT(collisions),
> > +	HINIC_NETDEV_STAT(rx_length_errors),
> > +	HINIC_NETDEV_STAT(rx_over_errors),
> > +	HINIC_NETDEV_STAT(rx_crc_errors),
> > +	HINIC_NETDEV_STAT(rx_frame_errors),
> > +	HINIC_NETDEV_STAT(rx_fifo_errors),
> > +	HINIC_NETDEV_STAT(rx_missed_errors),
> > +	HINIC_NETDEV_STAT(tx_aborted_errors),
> > +	HINIC_NETDEV_STAT(tx_carrier_errors),
> > +	HINIC_NETDEV_STAT(tx_fifo_errors),
> > +	HINIC_NETDEV_STAT(tx_heartbeat_errors),
> > +};  
> 
> I think we wanted to stop duplicating standard netdev stats in ethtool
> -S.  Chaojing please post a patch to remove this part, the other stats
> are good.

Please address this comment or I will send a revert of the entire patch.
